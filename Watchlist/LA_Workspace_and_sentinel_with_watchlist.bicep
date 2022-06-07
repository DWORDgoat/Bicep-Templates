 
//api docs https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines?tabs=bicep

// The workspace name can contain only letters, numbers and '-'. The '-' shouldn't be the first or the last symbol.
param workspacename string
param location string = 'norwayeast'
param retentionInDays int = 365

// Log analytics workspace
resource loganalyticsworkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: '${workspacename}LA'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: retentionInDays
  }
} 
// End of Log Analytics workspace

// Sentinel
resource sentinelsolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${loganalyticsworkspace.name})'
  location: location
  plan: {
    name: 'SecurityInsights(${loganalyticsworkspace.name})'
    product: 'OMSGallery/SecurityInsights'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  properties: {
    workspaceResourceId: loganalyticsworkspace.id
  }  
}

resource watchlist1 'Microsoft.SecurityInsights/watchlists@2021-04-01' = {
  name: 'list1'
  scope: loganalyticsworkspace
  dependsOn: [
    sentinelsolution
  ]
  properties: {
    contentType: 'text/csv'
    defaultDuration: '30'
    description: 'test1'
    displayName: 'test1'
    isDeleted: false
    itemsSearchKey: 'ExampleSearchKey'
    numberOfLinesToSkip: 0
    provider: 'Whatever'
    rawContent: 'ExampleSearchKey\nExampleValue'
    source: 'Remote storage'
    watchlistAlias: 'TST1'
  }
}

