param workspacename string

resource loganalyticsworkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: workspacename

}
resource watchlist1 'Microsoft.SecurityInsights/watchlists@2021-04-01' = {
  name: 'list2'
  scope: loganalyticsworkspace
  properties: {
    contentType: 'text/csv'
    defaultDuration: '30' 
    description: 'test2'
    displayName: 'test2'
    itemsSearchKey: 'ExampleSearchKey'
    numberOfLinesToSkip: 0
    provider: 'Whatever'
    rawContent: 'ExampleSearchKey\nExampleValue'
    source: 'Local file'
    watchlistAlias: 'TST2'
  }
}
