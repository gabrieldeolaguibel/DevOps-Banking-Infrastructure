param diagnosticsLogAnalyticsWorkspaceId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourcegroups/aguadamillas_students_2/providers/microsoft.operationalinsights/workspaces/lemonke-am'
param metricsToEnable array = ['AllMetrics']

resource appServicePlanProd 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-prod'
}

resource staticWebAppProd 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-prod'
}

resource appServiceAppProd 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-prod'
}

resource postgreSQLServerProd 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-prod'
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
