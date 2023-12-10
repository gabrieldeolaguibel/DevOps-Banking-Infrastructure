param diagnosticsLogAnalyticsWorkspaceId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourcegroups/aguadamillas_students_2/providers/microsoft.operationalinsights/workspaces/lemonke-am'
param metricsToEnable array = ['AllMetrics']

// Existing resource for keyvault
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: 'lemonke-kv' 
}

// Existing resource for ACR
resource cr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: 'lemonkecr'
 }

// Existing resources for App Service Plan (ASP)
resource appServicePlanDev 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-dev'
}
resource appServicePlanUat 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-uat'
}
resource appServicePlanProd 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-prod'
}
 
// Existing resources for Static Web Apps
resource staticWebAppDev 'Microsoft.Web/staticsites@2021-02-01' existing = {
  name: 'lemonke-fe-dev'
}
resource staticWebAppUat 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-uat'
}
resource staticWebAppProd 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-prod'
}

// Existing resources for App Service App - Backend
resource appServiceAppDev 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-dev'
}
resource appServiceAppUat 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-uat'
}
resource appServiceAppProd 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-prod'
}

// Existing resources for PostgreSQL
resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-dev'
}
resource postgreSQLServerUat 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-uat'
}
resource postgreSQLServerProd 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-prod'
}

// Function to create diagnostic settings for KeyVault
resource keyVaultDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-kv-diagnostics'
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

// Function to create diagnostic settings for CR
resource ACRDiagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lmonkecr-diagnostics'
  scope: cr
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [{
      category: 'ContainerRegistryLoginEvents'
      enabled: true
    }
    {
      category: 'ContainerRegistryRepositoryEvents' 
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for App Service Plan (ASP) DEV -> There are no logs for ASP
resource diagnosticSettingAppServicePlanDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
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

// Function to create diagnostic settings for App Service Plan (ASP) UAT -> There are no logs for ASP
resource diagnosticSettingAppServicePlanUAT 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-asp-uat-diagnostics'
  scope: appServicePlanUat
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for App Service Plan (ASP) PROD -> There are no logs for ASP
resource diagnosticSettingAppServicePlanPROD 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-asp-prod-diagnostics'
  scope: appServicePlanProd
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for Frontend Static App DEV-> logs are not activated as it costs money!
resource diagnosticSettingStaticWebAppDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
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

// Function to create diagnostic settings for Frontend Static App UAT -> logs are not activated as it costs money!
resource diagnosticSettingStaticWebAppUAT 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lmonke-fe-uat-diagnostics'
  scope: staticWebAppUat
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for Frontend Static App PROD -> logs are not activated as it costs money!
resource diagnosticSettingStaticWebAppPROD 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lmonke-fe-prod-diagnostics'
  scope: staticWebAppProd
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}

// Function to create diagnostic settings for Backend App Service DEV (BE)
resource diagnosticSettingAppServiceAppDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =  {
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

// Function to create diagnostic settings for Backend App Service UAT (BE)
resource diagnosticSettingAppServiceAppUAT 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =  {
  name: 'lemonke-be-uat-diagnostics'
  scope: appServiceAppUat
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

// Function to create diagnostic settings for Backend App Service PROD (BE)
resource diagnosticSettingAppServiceAppPROD 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' =  {
  name: 'lemonke-be-prod-diagnostics'
  scope: appServiceAppProd
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

// Azure Database for PostgreSQL DEV
resource diagnosticSettingPostgreSQLServerDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
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

// Azure Database for PostgreSQL UAT
resource diagnosticSettingPostgreSQLServerUAT 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-dbsrv-uat-diagnostics'
  scope: postgreSQLServerUat
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

// Azure Database for PostgreSQL PROD
resource diagnosticSettingPostgreSQLServerPROD 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-dbsrv-prod-diagnostics'
  scope: postgreSQLServerProd
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

