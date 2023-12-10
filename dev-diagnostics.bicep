param diagnosticsLogAnalyticsWorkspaceId string
param location string


resource appServicePlanDev 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-dev'
}

/* resource staticWebAppDev 'Microsoft.Web/staticsites@2021-02-01' existing = {
  name: 'lemonke-fe-dev'
}

resource appServiceAppDev 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-dev'
}

resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-dev'
} */


// Function to create diagnostic settings for App Service Plan (ASP) DEV -> There are no logs for ASP
resource diagnosticSettingAppServicePlanDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-asp-dev-diagnostics'
  scope: appServicePlanDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}

resource appServicePlanCpuAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'AppServicePlanCpuAlert-dev'
  location: location
  properties: {
    description: 'Alert when CPU utilization is over 80%'
    severity: 3
    enabled: true
    scopes: [
      appServicePlanDev.id
    ]
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          metricName: 'CpuPercentage'
          metricNamespace: 'Microsoft.Web/serverfarms'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
        }
      ]
    }
    windowSize: 'PT5M'
    evaluationFrequency: 'PT1M'
  }
}


/* // Function to create diagnostic settings for Frontend Static App DEV-> logs are not activated as it costs money!
resource diagnosticSettingStaticWebAppDEV 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lmonke-fe-dev-diagnostics'
  scope: staticWebAppDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}

resource staticWebAppErrorAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'StaticWebAppErrorAlert-dev'
  properties: {
    // Alert properties...
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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}

resource appServiceResponseTimeAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'AppServiceResponseTimeAlert-dev'
  properties: {
    // Alert properties...
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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}

resource postgreSQLPerformanceAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'PostgreSQLPerformanceAlert-dev'
  properties: {
    // Alert properties...
  }
}
 */
