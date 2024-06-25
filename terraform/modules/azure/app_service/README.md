<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_role_assignment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_service_plan.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The endpoint used to connect to the CosmosDB account. | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The name of the environment | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region to deploy the service to | `string` | `"westeurope"` | no |
| <a name="input_primary_sql_connection_string"></a> [primary\_sql\_connection\_string](#input\_primary\_sql\_connection\_string) | Primary SQL connection string for the CosmosDB Account. | `string` | n/a | yes |
| <a name="input_region_name"></a> [region\_name](#input\_region\_name) | The name of the storage account | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group to deploy the service to | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | n/a | <pre>map(object({<br>    name  = string<br>  }))</pre> | <pre>{<br>  "download": {<br>    "name": "download"<br>  },<br>  "metadata": {<br>    "name": "metadata"<br>  },<br>  "search": {<br>    "name": "search"<br>  },<br>  "upload": {<br>    "name": "upload"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webapp_default_hostnames"></a> [webapp\_default\_hostnames](#output\_webapp\_default\_hostnames) | n/a |
| <a name="output_webapp_identities"></a> [webapp\_identities](#output\_webapp\_identities) | n/a |
| <a name="output_webapp_ids"></a> [webapp\_ids](#output\_webapp\_ids) | n/a |
| <a name="output_webapp_names"></a> [webapp\_names](#output\_webapp\_names) | n/a |
<!-- END_TF_DOCS -->