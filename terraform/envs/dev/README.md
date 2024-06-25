<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.109.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | ../../modules/azure/cosmodb | n/a |
| <a name="module_frontdoor"></a> [frontdoor](#module\_frontdoor) | ../../modules/azure/frontdoor | n/a |
| <a name="module_webapps"></a> [webapps](#module\_webapps) | ../../modules/azure/app_service | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The deployment environment | `string` | `"dev"` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | The name of the resource groups to create and location | `map(string)` | <pre>{<br>  "asia": "southeastasia",<br>  "eu": "westeurope",<br>  "us": "eastus2"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->