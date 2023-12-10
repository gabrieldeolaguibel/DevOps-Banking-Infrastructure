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
