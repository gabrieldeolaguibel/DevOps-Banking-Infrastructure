param diagnosticsLogAnalyticsWorkspaceId string
param location string = 'global'
param actionGroupId string = '/subscriptions/e0b9cada-61bc-4b5a-bd7a-52c606726b3b/resourceGroups/aguadamillas_students_2/providers/Microsoft.Logic/workflows/lemonke-slack'


// Existing resource for keyvault
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: 'lemonke-kv' 
}

// Existing resource for ACR
resource cr 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: 'lemonkecr'
 }


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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}


// Function to create alert for KeyVault
resource keyVaultLatencyAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-lemonke-kv'
  location: location
  properties: {
    description: 'Alert when latency is over 100ms'
    severity: 3
    enabled: true
    scopes: [
      keyVault.id
    ]
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'alert-lemonke-kv'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'ServiceApiLatency'
          metricNamespace: 'Microsoft.KeyVault/vaults'
          operator: 'GreaterThan'
          threshold: 100
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
    metrics: [{
      category: 'AllMetrics'
      enabled: true
    }]
  }
}

// THERE ARE NO AVAILABLE ALERTS FOR ACR
