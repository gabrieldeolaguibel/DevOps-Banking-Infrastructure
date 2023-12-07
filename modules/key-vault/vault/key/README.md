# Key Vault Keys `[Microsoft.KeyVault/vaults/keys]`

This module deploys a Key Vault Key.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Notes](#Notes)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/roleAssignments` | [2022-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2022-04-01/roleAssignments) |
| `Microsoft.KeyVault/vaults/keys` | [2022-07-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.KeyVault/2022-07-01/vaults/keys) |

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | The name of the key. |

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`keyVaultName`](#parameter-keyvaultname) | string | The name of the parent key vault. Required if the template is used in a standalone deployment. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`attributesEnabled`](#parameter-attributesenabled) | bool | Determines whether the object is enabled. |
| [`attributesExp`](#parameter-attributesexp) | int | Expiry date in seconds since 1970-01-01T00:00:00Z. For security reasons, it is recommended to set an expiration date whenever possible. |
| [`attributesNbf`](#parameter-attributesnbf) | int | Not before date in seconds since 1970-01-01T00:00:00Z. |
| [`curveName`](#parameter-curvename) | string | The elliptic curve name. |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`keyOps`](#parameter-keyops) | array | Array of JsonWebKeyOperation. |
| [`keySize`](#parameter-keysize) | int | The key size in bits. For example: 2048, 3072, or 4096 for RSA. |
| [`kty`](#parameter-kty) | string | The type of the key. |
| [`roleAssignments`](#parameter-roleassignments) | array | Array of role assignment objects that contain the 'roleDefinitionIdOrName' and 'principalId' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or its fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'. |
| [`rotationPolicy`](#parameter-rotationpolicy) | object | Key rotation policy properties object. |
| [`tags`](#parameter-tags) | object | Resource tags. |

### Parameter: `name`

The name of the key.

- Required: Yes
- Type: string

### Parameter: `keyVaultName`

The name of the parent key vault. Required if the template is used in a standalone deployment.

- Required: Yes
- Type: string

### Parameter: `attributesEnabled`

Determines whether the object is enabled.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `attributesExp`

Expiry date in seconds since 1970-01-01T00:00:00Z. For security reasons, it is recommended to set an expiration date whenever possible.

- Required: No
- Type: int
- Default: `-1`

### Parameter: `attributesNbf`

Not before date in seconds since 1970-01-01T00:00:00Z.

- Required: No
- Type: int
- Default: `-1`

### Parameter: `curveName`

The elliptic curve name.

- Required: No
- Type: string
- Default: `'P-256'`
- Allowed:
  ```Bicep
  [
    'P-256'
    'P-256K'
    'P-384'
    'P-521'
  ]
  ```

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).

- Required: No
- Type: bool
- Default: `True`

### Parameter: `keyOps`

Array of JsonWebKeyOperation.

- Required: No
- Type: array
- Default: `[]`
- Allowed:
  ```Bicep
  [
    'decrypt'
    'encrypt'
    'import'
    'sign'
    'unwrapKey'
    'verify'
    'wrapKey'
  ]
  ```

### Parameter: `keySize`

The key size in bits. For example: 2048, 3072, or 4096 for RSA.

- Required: No
- Type: int
- Default: `-1`

### Parameter: `kty`

The type of the key.

- Required: No
- Type: string
- Default: `'EC'`
- Allowed:
  ```Bicep
  [
    'EC'
    'EC-HSM'
    'RSA'
    'RSA-HSM'
  ]
  ```

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

### Parameter: `rotationPolicy`

Key rotation policy properties object.

- Required: No
- Type: object
- Default: `{}`

### Parameter: `tags`

Resource tags.

- Required: No
- Type: object


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the key. |
| `resourceGroupName` | string | The name of the resource group the key was created in. |
| `resourceId` | string | The resource ID of the key. |

## Cross-referenced modules

_None_

## Notes

### Parameter Usage: `rotationPolicy`

Configures a [auto-rotation policy](https://learn.microsoft.com/en-us/azure/key-vault/keys/how-to-configure-key-rotation) for the key.
Remarks:

- The times should use the ISO 8601 duration format, e.g. `P1Y` (1 year), `P2M`, (2 months), `P90D` (90 days).
- The `trigger` property of `lifetimeActions` can contain one of the following properties:
  - `timeAfterCreate` - The time duration after key creation to rotate the key. It only applies to rotate.
  - `timeBeforeExpiry` - The time duration before key expiring to rotate or notify. To use this, the key must have an expiration date configured.

<details>

<summary>Parameter JSON format</summary>

```json
"rotationPolicy": {
    "value": {
        "attributes": {
            "expiryTime": "P2Y"
        },
        "lifetimeActions": [
            {
                "trigger": {
                    "timeBeforeExpiry": "P2M"
                },
                "action": {
                    "type": "Rotate"
                }
            },
            {
                "trigger": {
                    "timeBeforeExpiry": "P30D"
                },
                "action": {
                    "type": "Notify"
                }
            }
        ]
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
rotationPolicy: {
    attributes: {
        expiryTime: 'P2Y'
    }
    lifetimeActions: [
        {
            trigger: {
                timeBeforeExpiry: 'P2M'
            }
            action: {
                type: 'Rotate'
            }
        }
        {
            trigger: {
                timeBeforeExpiry: 'P30D'
            }
            action: {
                type: 'Notify'
            }
        }
    ]
}
```

</details>
<p>
