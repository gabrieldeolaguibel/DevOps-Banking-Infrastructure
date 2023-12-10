param diagnosticsLogAnalyticsWorkspaceId string

resource appServicePlanProd 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-prod'
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
    metrics: [{
      category: 'AllMetrics'
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
    metrics: [{
      category: 'AllMetrics'
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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}
