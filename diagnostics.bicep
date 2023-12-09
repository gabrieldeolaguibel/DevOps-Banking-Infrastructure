param diagnosticsLogAnalyticsWorkspaceId string
param metricsToEnable array = ['AllMetrics']

// Existing resource for keyvault
resource keyVault 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: 'lemonke-keyvault' 
}

// Existing resources for App Service Plan (ASP)
resource appServicePlanDev 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-dev'
}
/* resource appServicePlanUat 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-uat'
}
resource appServicePlanProd 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-prod'
}
 */
 
// Existing resources for Static Web Apps
resource staticWebAppDev 'Microsoft.Web/staticsites@2021-02-01' existing = {
  name: 'lemonke-fe-dev'
}
/* resource staticWebAppUat 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-uat'
}
resource staticWebAppProd 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-prod'
} */

// Existing resources for App Service App - Backend
resource appServiceAppDev 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-dev'
}
/*resource appServiceAppUat 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-uat'
}
resource appServiceAppProd 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-prod'
} */

// Existing resources for PostgreSQL
resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-dev'
}
/* resource postgreSQLServerUat 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: 'lemonke-dbsrv-uat'
}
resource postgreSQLServerProd 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: 'lemonke-dbsrv-prod'
} */

// Function to create diagnostic settings for KeyVault
resource keyVaultDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'keyvault-diagnostics'
  scope: keyVault
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [{
      category: 'AuditEvent'
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for App Service Plan (ASP) -> There are no logs for ASP
resource diagnosticSettingAppServicePlan 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-asp-dev-diagnostics'
  scope: appServicePlanDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for Frontend Static App -> logs are not activated as it costs money!
resource diagnosticSettingStaticWebApp 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lmonke-fe-dev-diagnostics'
  scope: staticWebAppDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for Backend App Service (BE)
resource diagnosticSettingAppServiceApp 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =  {
  name: 'lemonke-be-dev-diagnostics'
  scope: appServiceAppDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [{
      category: 'AppServiceHTTPLogs'
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Azure Database for PostgreSQL
resource diagnosticSettingPostgreSQLServer 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-dbsrv-dev-diagnostics'
  scope: postgreSQLServerDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [{
      category: 'PostgreSQLLogs'
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

