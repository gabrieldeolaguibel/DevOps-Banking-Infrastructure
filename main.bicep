// Main.bicep

// Parameters
param location string = 'Norway East'
param postgreSQLServerName string
param postgreSQLDatabaseName string


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
module servicePlan './modules/web/serverfarm/main.bicep' = {
  name: appServicePlanName
  params: {
    name: appServicePlanName
    location: location
    sku: {
      capacity: 1
      family: 'B'
      name: 'B1'
      size: 'B1'
      tier: 'Basic'
    }
    reserved: true
  }
}

// Azure Web App for Linux containers module

//parameters for App Service
param appServiceAppName string
param appServiceAPIAppName string
param appServicePlanName string
param appServiceAPIDBHostDBUSER string
param appServiceAPIDBHostFLASK_APP string
param appServiceAPIDBHostFLASK_DEBUG string
param appServiceAPIEnvVarDBHOST string
param appServiceAPIEnvVarDBNAME string
param appServiceAPIEnvVarDBPASS string
param appServiceAPIEnvVarENV string
param environmentType string
module appService 'modules/app-service.bicep' = {
  name: 'appService'
  params: {
    location: location
    environmentType: environmentType
    appServiceAppName: appServiceAppName
    appServiceAPIAppName: appServiceAPIAppName
    appServicePlanName: appServicePlanName
    appServiceAPIDBHostDBUSER: appServiceAPIDBHostDBUSER
    appServiceAPIDBHostFLASK_APP: appServiceAPIDBHostFLASK_APP
    appServiceAPIDBHostFLASK_DEBUG: appServiceAPIDBHostFLASK_DEBUG
    appServiceAPIEnvVarDBHOST: appServiceAPIEnvVarDBHOST
    appServiceAPIEnvVarDBNAME: appServiceAPIEnvVarDBNAME
    appServiceAPIEnvVarDBPASS: appServiceAPIEnvVarDBPASS
    appServiceAPIEnvVarENV: appServiceAPIEnvVarENV
  }
  dependsOn: [
    dbForPostgreSQL
  ]
}



