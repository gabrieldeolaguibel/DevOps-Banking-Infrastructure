// Main.bicep

// Parameters
param location string
param ENV string = 'prod' 
param postgreSQLServerName string
param postgreSQLDatabaseName string
param slackWebhookUrl string = ''
param logicAppName string = ''

// Exisiting resources
param resourceGroupName string = 'aguadamillas_students_1'

param keyVaultName string = 'lemonke-kv'
//key vault reference
resource keyvault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  scope: resourceGroup(resourceGroupName)
  name: keyVaultName
 }

// Azure Container Registry module
param containerRegistryName string = 'lemonkecr'
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  scope: resourceGroup(resourceGroupName)
  name: containerRegistryName
 }

 // Static web app for front end
param staticWebAppName string
param githubToken string
param githubRepo string
module staticWebApp './modules/web/static-site/main.bicep' = {
  name: staticWebAppName
  params: {
    name: staticWebAppName
    location: location
    sku: 'Standard'
    repositoryToken: githubToken
    repositoryUrl: githubRepo
    branch: 'main'
    buildProperties: {
      appLocation: '/'
      apiLocation: ''
      outputLocation: ''
      appArtifactLocation: ''
      apiArtifactLocation: ''
    }
  }
}

//linked backend app to frontend app
module linkedBackend './modules/web/static-site/linked-backend/main.bicep' = {
  name: '${staticWebAppName}-linkedBackend'
  dependsOn: [
    staticWebApp
    webApp
  ]
    params: {
      name: appServiceAppName
      location: location
      staticSiteName: staticWebApp.outputs.name
      backendResourceId: webApp.outputs.resourceId
      region: location
  }
}

// Flexible server for PostgreSQL module
module flexibleServer './modules/db-for-postgre-sql/flexible-server/main.bicep' = {
  name: postgreSQLServerName
  params: {
    // Required parameters
    name: postgreSQLServerName
    location: location
    skuName: 'Standard_B2s'
    tier: 'Burstable'
    // Non-required parameters
    administratorLogin: 'maudandjannik'
    administratorLoginPassword: 'mj1234'
  }
}

// DB for postegreSQL module
module dbForPostgreSQL './modules/db-for-postgre-sql/flexible-server/database/main.bicep' = {
  name: postgreSQLDatabaseName
  params: {
    // Required parameters
    name: postgreSQLDatabaseName
    location: location
    flexibleServerName: flexibleServer.outputs.name
  }
}

// Azure Service Plan for Linux module
param appServicePlanName string
param sku object
module servicePlan './modules/web/serverfarm/main.bicep' = {
  name: appServicePlanName
  params: {
    name: appServicePlanName
    location: location
    sku: sku
    reserved: true
  }
}

// Azure Web App for Linux containers module (Back-end)
//parameters for App Service
param containerRegistryImageName string = 'backend'
param containerRegistryImageVersion string = 'latest'

param appServiceAppName string // backend app hosting 
param keyVaultSecretNameACRUsername string = 'acr-username'
param keyVaultSecretNameACRPassword1 string = 'acr-password1'

param DBHOST string
param DBUSER string
param DBPASS string
param DBNAME string

module webApp './modules/web/site/main.bicep' = {
  name: appServiceAppName
  dependsOn: [
    servicePlan
    acr
    dbForPostgreSQL
  ]
  params: {
    name: appServiceAppName
    location: location
    kind: 'app'
    serverFarmResourceId: servicePlan.outputs.resourceId
    siteConfig: {
      linuxFxVersion: 'DOCKER|${containerRegistryName}.azurecr.io/${containerRegistryImageName}:${containerRegistryImageVersion}'
      appCommandLine: ''
    }
    appSettingsKeyValuePairs: {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE: false
      ENV: ENV
      DBHOST: DBHOST
      DBUSER: DBUSER
      DBPASS: DBPASS
      DBNAME: DBNAME
      FLASK_APP: 'app.py'
      FLASK_DEBUG: '1'
    }
    dockerRegistryServerUrl: 'https://${containerRegistryName}.azurecr.io'
    dockerRegistryServerUserName: keyvault.getSecret(keyVaultSecretNameACRUsername)
    dockerRegistryServerPassword: keyvault.getSecret(keyVaultSecretNameACRPassword1)
  }
}


// Monitoring Parameters

@sys.description('The name of the Azure Monitor workspace')
param azureMonitorName string
@sys.description('The name of the Application Insights')
param appInsightsName string

resource azureMonitor 'Microsoft.OperationalInsights/workspaces@2020-08-01' = if (ENV == 'prod' && azureMonitorName != 'dummy-value') {
  name: azureMonitorName
  location: location
} 

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    // Conditional linking to Azure Monitor
    WorkspaceResourceId: ( ENV == 'prod' && azureMonitorName != 'dummy-value' ) ? resourceId('Microsoft.OperationalInsights/workspaces', azureMonitorName) : null
  }
}

// Slack Integration


resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = if (ENV == 'prod' && slackWebhookUrl != '') {
  name: logicAppName
  location: location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      triggers: {
        manual: {
          type: 'Request'
          kind: 'Http'
          inputs: {
            method: 'POST'
            schema: {}
          }
        }
      }
      actions: {
        sendToSlack: {
          type: 'Http'
          inputs: {
            method: 'POST'
            uri: slackWebhookUrl
            headers: {
              'Content-Type': 'application/json'
            }
            body: {
              text: 'Alert from Azure Monitor: @{triggerBody()}'
            }
          }
          runAfter: {}
        }
      }
    }
  }
}

