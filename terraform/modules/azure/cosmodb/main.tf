resource "azurerm_cosmosdb_account" "main" {
  name                = "${var.env}-${var.db_name}-0x87752"
  location            = var.location
  resource_group_name = var.rg_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  # free_tier_enabled = true
  multiple_write_locations_enabled = true

  consistency_policy {
    consistency_level       = "Session"
  }

  geo_location {
    location          = "EastUS2"
    failover_priority = 0
  }

  geo_location {
    location          = "NorthEurope"
    failover_priority = 1
  }

  geo_location {
    location          = "SoutheastAsia"
    failover_priority = 2
  }

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "image-metadata-db"
  resource_group_name = var.rg_name
  account_name        = azurerm_cosmosdb_account.main.name
}

resource "azurerm_cosmosdb_sql_container" "main" {
  name                  = "metadata"
  resource_group_name   = var.rg_name
  account_name          = azurerm_cosmosdb_account.main.name
  database_name         = azurerm_cosmosdb_sql_database.main.name
  partition_key_path    = "/partitionKey"
  throughput            = 400
}
