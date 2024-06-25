output "cosmodb_account_id" {
  description = "The id of the cosmodb account"
  value = azurerm_cosmosdb_account.main.id
}

output "primary_sql_connection_string" {
  description = "Primary SQL connection string for the CosmosDB Account."
  value = azurerm_cosmosdb_account.main.primary_sql_connection_string
}

output "endpoint" {
  description = "The endpoint used to connect to the CosmosDB account."
  value = azurerm_cosmosdb_account.main.endpoint
}


output "read_endpoints" {
  description = "A list of read endpoints available for this CosmosDB account."
  value = azurerm_cosmosdb_account.main.read_endpoints
}

output "write_endpoints" {
  description = "A list of write endpoints available for this CosmosDB account."
  value = azurerm_cosmosdb_account.main.write_endpoints
}