# Create resource groups 
resource "azurerm_resource_group" "main" {
  for_each = var.regions
  name     = "${var.env}-${each.key}-rg"
  location = each.value
}

# Create webapps and storage accounts
module "webapps" {
  source = "../../modules/azure/app_service"
  for_each = var.regions
  region_name = each.key
  location = each.value
  rg_name = azurerm_resource_group.main[each.key].name
  env = var.env
  endpoint = module.db.endpoint
  primary_sql_connection_string = module.db.primary_sql_connection_string
}

# Shared dev resource group
resource "azurerm_resource_group" "dev" {
  name     = "${var.env}-rg"
  location = "westeurope"
}

# CosmoDB
module "db" {
  source = "../../modules/azure/cosmodb"
  rg_name = azurerm_resource_group.dev.name
  location = azurerm_resource_group.dev.location
  db_name = "abaxcosmodb"
  env = var.env
}

locals {
  flattened_hostnames = merge([
    for region, webapp in module.webapps : 
      { for service, hostname in webapp.webapp_default_hostnames : 
        "${region}-${service}" => hostname 
      }
  ]...)
}

# Front Door
module "frontdoor" {
  source = "../../modules/azure/frontdoor"
  env = var.env
  rg_name = azurerm_resource_group.dev.name
  webapps = local.flattened_hostnames
}
