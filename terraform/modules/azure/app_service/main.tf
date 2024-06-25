# Create app service plan
resource "azurerm_service_plan" "main" {
  name                = "${var.env}-${var.region_name}-asp"
  location            = var.location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Create webapp
resource "azurerm_linux_web_app" "main" {
  for_each            = var.services
  name                = "${var.env}-${var.region_name}-${each.value.name}-webapp"
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id = azurerm_service_plan.main.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "COSMODB_ENDPOINT" = var.endpoint
    "COSMODB_PRIMARY_SQL_CONNECTION_STRING" = var.primary_sql_connection_string
  }
}

# Create a Storage Account
resource "azurerm_storage_account" "main" {
  name                     = "${var.env}abaxsa00${var.region_name}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

# Create a Storage Container
resource "azurerm_storage_container" "main" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "main" {
  for_each            = var.services
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_web_app.main[each.key].identity[0].principal_id
}
