param containerRegistryName string
param location string

module acr './modules/container-registry/registry/main.bicep' = {
  name: containerRegistryName
  params: {
    name: containerRegistryName
    location: location
    acrAdminUserEnabled: true
  }
}
