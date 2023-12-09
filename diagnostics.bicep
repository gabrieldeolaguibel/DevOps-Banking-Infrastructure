param diagnosticsLogAnalyticsWorkspaceId string
param logsToEnable array = ['HttpLogs', 'AppServiceConsoleLogs']
param metricsToEnable array = ['AllMetrics']

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
 
/* // Existing resources for Static Web Apps
resource staticWebAppDev 'Microsoft.Web/staticSites@2021-02-01' existing = {
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
resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: 'lemonke-dbsrv-dev'
}
resource postgreSQLServerUat 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: 'lemonke-dbsrv-uat'
}
resource postgreSQLServerProd 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: 'lemonke-dbsrv-prod'
} */


/* // Function to create diagnostic settings for App Service Plan (ASP)
resource diagnosticSettingAppServicePlan 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for env in ['dev', 'uat', 'prod']: {
  name: 'lemonke-asp-${env}-diagnostics'
  scope: (env == 'dev') ? appServicePlanDev : (env == 'uat') ? appServicePlanUat : appServicePlanProd
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [for log in logsToEnable: {
      category: log
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}] */

resource diagnosticSettingAppServicePlan 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'lemonke-asp-dev-diagnostics'
  scope: appServicePlanDev
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [for log in logsToEnable: {
      category: log
      enabled: true
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
    }]
  }
}


/* // Function to create diagnostic settings for Frontend
resource diagnosticSettingStaticWebApp 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for env in ['dev', 'uat', 'prod']: {
  name: 'lmonke-fe-${env}-diagnostics'
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [for log in logsToEnable: {
      category: log
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
  }
  scope: (env == 'dev') ? staticWebAppDev : (env == 'uat') ? staticWebAppUat : staticWebAppProd
}]

// Function to create diagnostic settings for Backend App Service (BE)
resource diagnosticSettingAppServiceApp 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for env in ['dev', 'uat', 'prod']: {
  name: 'lemonke-be-${env}-diagnostics'
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [for log in logsToEnable: {
      category: log
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
  }
  scope: (env == 'dev') ? appServiceAppDev : (env == 'uat') ? appServiceAppUat : appServiceAppProd
}]

// Azure Database for PostgreSQL
resource diagnosticSettingPostgreSQLServer 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [for env in ['dev', 'uat', 'prod']: {
  name: '${env}-postgresql-diagnostics'
  properties: {
    workspaceId: diagnosticsLogAnalyticsWorkspaceId
    logs: [for log in logsToEnable: {
      category: log
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
    metrics: [for metric in metricsToEnable: {
      category: metric
      enabled: true
      retentionPolicy: {
        enabled: true
        days: 30
      }
    }]
  }
  scope: (env == 'dev') ? postgreSQLServerDev : (env == 'uat') ? postgreSQLServerUat : postgreSQLServerProd
}]
 */
