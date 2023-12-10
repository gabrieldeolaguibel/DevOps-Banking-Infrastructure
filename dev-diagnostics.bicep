param diagnosticsLogAnalyticsWorkspaceId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourcegroups/aguadamillas_students_2/providers/microsoft.operationalinsights/workspaces/lemonke-am'
param metricsToEnable array = ['AllMetrics']


resource appServicePlanDev 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-dev'
}

resource staticWebAppDev 'Microsoft.Web/staticsites@2021-02-01' existing = {
  name: 'lemonke-fe-dev'
}

resource appServiceAppDev 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-dev'
}

resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-dev'
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
