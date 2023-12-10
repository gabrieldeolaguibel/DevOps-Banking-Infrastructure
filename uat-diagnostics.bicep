param diagnosticsLogAnalyticsWorkspaceId string

resource appServicePlanUat 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-uat'
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
    metrics: [{
      category: 'AllMetrics'
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
    metrics: [{
      category: 'AllMetrics'
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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}
