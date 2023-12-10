param diagnosticsLogAnalyticsWorkspaceId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourcegroups/aguadamillas_students_2/providers/microsoft.operationalinsights/workspaces/lemonke-am'
param metricsToEnable array = ['AllMetrics']

resource appServicePlanUat 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-uat'
}

resource staticWebAppUat 'Microsoft.Web/staticSites@2021-02-01' existing = {
  name: 'lemonke-fe-uat'
}

resource appServiceAppUat 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-uat'
}

resource postgreSQLServerUat 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-uat'
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
