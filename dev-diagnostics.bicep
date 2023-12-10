param diagnosticsLogAnalyticsWorkspaceId string
param location string = 'global'
param actionGroupId string
param resourceId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourceGroups/aguadamillas_students_2/providers/Microsoft.Logic/workflows/lemonke-slack'
param slackWebhookUrl string = 'https://hooks.slack.com/services/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'


resource appServicePlanDev 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: 'lemonke-asp-dev'
}

resource appServiceAppDev 'Microsoft.Web/sites@2021-02-01' existing = {
  name: 'lemonke-be-dev'
}

resource postgreSQLServerDev 'Microsoft.DBforPostgreSQL/flexibleservers@2021-06-01' existing = {
  name: 'lemonke-dbsrv-dev'
}

// Define the Action Group
resource actionGroup 'Microsoft.Insights/actionGroups@2022-06-01' = {
  name: 'lmonke-ag'
  location: 'global'
  properties: {
    groupShortName: 'lmonke-ag'
    enabled: true
    armRoleReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    itsmReceivers: []
    logicAppReceivers: [
      {
        name: 'SendToSlack'
        resourceId: resourceId
        useCommonAlertSchema: true
        callbackUrl: slackWebhookUrl
      }
    ]
    smsReceivers: []
    voiceReceivers: []
    webhookReceivers: []
  }
}


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

resource appServicePlanCpuAlertDEV 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-lemonke-asp-dev'
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
          name: 'alert-lemonke-asp-dev'
          criterionType: 'StaticThresholdCriterion'
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
    actions: [
      {
        actionGroupId: actionGroupId // Logic app id
      }
    ]
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

resource appServiceResponseTimeAlertDEV 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-lemonke-be-dev'
  location: location
  properties: {
    description: 'Alert when average response time is over 200ms'
    severity: 3
    enabled: true
    scopes: [
      appServiceAppDev.id
    ]
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'alert-lemonke-be-dev'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'AverageResponseTime'
          metricNamespace: 'Microsoft.Web/sites'
          operator: 'GreaterThan'
          threshold: 200
          timeAggregation: 'Average'
        }
      ]
    }
    windowSize: 'PT5M'
    evaluationFrequency: 'PT1M'
    actions: [
      {
        actionGroupId: actionGroupId // Logic app id
      }
    ]
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

resource postgreSQLCpuUtilizationAlertDEV 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-lemonke-dbsrv-dev'
  location: location
  properties: {
    description: 'Alert when CPU utilization is over 70%'
    severity: 3
    enabled: true
    scopes: [
      postgreSQLServerDev.id
    ]
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'alert-lemonke-dbsrv-dev'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'cpu_percent'
          metricNamespace: 'Microsoft.DBforPostgreSQL/flexibleservers'
          operator: 'GreaterThan'
          threshold: 70
          timeAggregation: 'Average'
        }
      ]
    }
    windowSize: 'PT5M'
    evaluationFrequency: 'PT1M'
    actions: [
      {
        actionGroupId: actionGroupId // Logic app id
      }
    ]
  }
}
