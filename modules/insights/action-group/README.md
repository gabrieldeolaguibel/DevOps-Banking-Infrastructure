# Action Groups `[Microsoft.Insights/actionGroups]`

> This module has already been migrated to [AVM](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res). Only the AVM version is expected to receive updates / new features. Please do not work on improving this module in [CARML](https://aka.ms/carml).

This module deploys an Action Group.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Notes](#Notes)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.Insights/actionGroups` | [2023-01-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Insights/2023-01-01/actionGroups) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br:bicep/modules/insights.action-group:1.0.0`.

- [Using only defaults](#example-1-using-only-defaults)
- [Using large parameter set](#example-2-using-large-parameter-set)
- [WAF-aligned](#example-3-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module actionGroup 'br:bicep/modules/insights.action-group:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-iagmin'
  params: {
    // Required parameters
    groupShortName: 'agiagmin001'
    name: 'iagmin001'
    // Non-required parameters
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "groupShortName": {
      "value": "agiagmin001"
    },
    "name": {
      "value": "iagmin001"
    },
    // Non-required parameters
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    }
  }
}
```

</details>
<p>

### Example 2: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module actionGroup 'br:bicep/modules/insights.action-group:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-iagmax'
  params: {
    // Required parameters
    groupShortName: 'agiagmax001'
    name: 'iagmax001'
    // Non-required parameters
    emailReceivers: [
      {
        emailAddress: 'test.user@testcompany.com'
        name: 'TestUser_-EmailAction-'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'test.user2@testcompany.com'
        name: 'TestUser2'
        useCommonAlertSchema: true
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    smsReceivers: [
      {
        countryCode: '1'
        name: 'TestUser_-SMSAction-'
        phoneNumber: '2345678901'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "groupShortName": {
      "value": "agiagmax001"
    },
    "name": {
      "value": "iagmax001"
    },
    // Non-required parameters
    "emailReceivers": {
      "value": [
        {
          "emailAddress": "test.user@testcompany.com",
          "name": "TestUser_-EmailAction-",
          "useCommonAlertSchema": true
        },
        {
          "emailAddress": "test.user2@testcompany.com",
          "name": "TestUser2",
          "useCommonAlertSchema": true
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        }
      ]
    },
    "smsReceivers": {
      "value": [
        {
          "countryCode": "1",
          "name": "TestUser_-SMSAction-",
          "phoneNumber": "2345678901"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>

### Example 3: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module actionGroup 'br:bicep/modules/insights.action-group:1.0.0' = {
  name: '${uniqueString(deployment().name, location)}-test-iagwaf'
  params: {
    // Required parameters
    groupShortName: 'agiagwaf001'
    name: 'iagwaf001'
    // Non-required parameters
    emailReceivers: [
      {
        emailAddress: 'test.user@testcompany.com'
        name: 'TestUser_-EmailAction-'
        useCommonAlertSchema: true
      }
      {
        emailAddress: 'test.user2@testcompany.com'
        name: 'TestUser2'
        useCommonAlertSchema: true
      }
    ]
    enableDefaultTelemetry: '<enableDefaultTelemetry>'
    roleAssignments: [
      {
        principalId: '<principalId>'
        principalType: 'ServicePrincipal'
        roleDefinitionIdOrName: 'Reader'
      }
    ]
    smsReceivers: [
      {
        countryCode: '1'
        name: 'TestUser_-SMSAction-'
        phoneNumber: '2345678901'
      }
    ]
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "groupShortName": {
      "value": "agiagwaf001"
    },
    "name": {
      "value": "iagwaf001"
    },
    // Non-required parameters
    "emailReceivers": {
      "value": [
        {
          "emailAddress": "test.user@testcompany.com",
          "name": "TestUser_-EmailAction-",
          "useCommonAlertSchema": true
        },
        {
          "emailAddress": "test.user2@testcompany.com",
          "name": "TestUser2",
          "useCommonAlertSchema": true
        }
      ]
    },
    "enableDefaultTelemetry": {
      "value": "<enableDefaultTelemetry>"
    },
    "roleAssignments": {
      "value": [
        {
          "principalId": "<principalId>",
          "principalType": "ServicePrincipal",
          "roleDefinitionIdOrName": "Reader"
        }
      ]
    },
    "smsReceivers": {
      "value": [
        {
          "countryCode": "1",
          "name": "TestUser_-SMSAction-",
          "phoneNumber": "2345678901"
        }
      ]
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    }
  }
}
```

</details>
<p>


## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`groupShortName`](#parameter-groupshortname) | string | The short name of the action group. |
| [`name`](#parameter-name) | string | The name of the action group. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`armRoleReceivers`](#parameter-armrolereceivers) | array | The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported. |
| [`automationRunbookReceivers`](#parameter-automationrunbookreceivers) | array | The list of AutomationRunbook receivers that are part of this action group. |
| [`azureAppPushReceivers`](#parameter-azureapppushreceivers) | array | The list of AzureAppPush receivers that are part of this action group. |
| [`azureFunctionReceivers`](#parameter-azurefunctionreceivers) | array | The list of function receivers that are part of this action group. |
| [`emailReceivers`](#parameter-emailreceivers) | array | The list of email receivers that are part of this action group. |
| [`enabled`](#parameter-enabled) | bool | Indicates whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications. |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`itsmReceivers`](#parameter-itsmreceivers) | array | The list of ITSM receivers that are part of this action group. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`logicAppReceivers`](#parameter-logicappreceivers) | array | The list of logic app receivers that are part of this action group. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| [`smsReceivers`](#parameter-smsreceivers) | array | The list of SMS receivers that are part of this action group. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`voiceReceivers`](#parameter-voicereceivers) | array | The list of voice receivers that are part of this action group. |
| [`webhookReceivers`](#parameter-webhookreceivers) | array | The list of webhook receivers that are part of this action group. |

### Parameter: `groupShortName`

The short name of the action group.

- Required: Yes
- Type: string

### Parameter: `name`

The name of the action group.

- Required: Yes
- Type: string

### Parameter: `armRoleReceivers`

The list of ARM role receivers that are part of this action group. Roles are Azure RBAC roles and only built-in roles are supported.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `automationRunbookReceivers`

The list of AutomationRunbook receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `azureAppPushReceivers`

The list of AzureAppPush receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `azureFunctionReceivers`

The list of function receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `emailReceivers`

The list of email receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `enabled`

Indicates whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).

- Required: No
- Type: bool
- Default: `True`

### Parameter: `itsmReceivers`

The list of ITSM receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `location`

Location for all resources.

- Required: No
- Type: string
- Default: `'global'`

### Parameter: `logicAppReceivers`

The list of logic app receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `roleAssignments`

Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.

- Required: No
- Type: array

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`principalId`](#parameter-roleassignmentsprincipalid) | string | The principal ID of the principal (user/group/identity) to assign the role to. |
| [`roleDefinitionIdOrName`](#parameter-roleassignmentsroledefinitionidorname) | string | The name of the role to assign. If it cannot be found you can specify the role definition ID instead. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`condition`](#parameter-roleassignmentscondition) | string | The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container" |
| [`conditionVersion`](#parameter-roleassignmentsconditionversion) | string | Version of the condition. |
| [`delegatedManagedIdentityResourceId`](#parameter-roleassignmentsdelegatedmanagedidentityresourceid) | string | The Resource Id of the delegated managed identity resource. |
| [`description`](#parameter-roleassignmentsdescription) | string | The description of the role assignment. |
| [`principalType`](#parameter-roleassignmentsprincipaltype) | string | The principal type of the assigned principal ID. |

### Parameter: `roleAssignments.principalId`

The principal ID of the principal (user/group/identity) to assign the role to.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.roleDefinitionIdOrName`

The name of the role to assign. If it cannot be found you can specify the role definition ID instead.

- Required: Yes
- Type: string

### Parameter: `roleAssignments.condition`

The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container"

- Required: No
- Type: string

### Parameter: `roleAssignments.conditionVersion`

Version of the condition.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    '2.0'
  ]
  ```

### Parameter: `roleAssignments.delegatedManagedIdentityResourceId`

The Resource Id of the delegated managed identity resource.

- Required: No
- Type: string

### Parameter: `roleAssignments.description`

The description of the role assignment.

- Required: No
- Type: string

### Parameter: `roleAssignments.principalType`

The principal type of the assigned principal ID.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'Device'
    'ForeignGroup'
    'Group'
    'ServicePrincipal'
    'User'
  ]
  ```

### Parameter: `smsReceivers`

The list of SMS receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

### Parameter: `voiceReceivers`

The list of voice receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`

### Parameter: `webhookReceivers`

The list of webhook receivers that are part of this action group.

- Required: No
- Type: array
- Default: `[]`


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the action group . |
| `resourceGroupName` | string | The resource group the action group was deployed into. |
| `resourceId` | string | The resource ID of the action group . |

## Cross-referenced modules

_None_

## Notes

- Receiver name must be unique across the ActionGroup.
- Email, SMS, Azure App push and Voice can be grouped in the same Action. To do so, the `name` field of the receivers must be in the `RecName_-ActionType-` format where:
  - _RecName_ is the name you want to give to the Action
  - _ActionType_ is one of the action types that can be grouped together. Possible values are:
    - EmailAction
    - SMSAction
    - AzureAppAction
    - VoiceAction

- To understand the impact of the `useCommonAlertSchema` field, see [documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/platform/alerts-common-schema).
