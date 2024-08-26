<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_github"></a> [github](#provider\_github) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application_federated_identity_credential.service_principal_credential](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_federated_identity_credential.service_principal_credential_pr](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_application_registration.app_registration](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_registration) | resource |
| [azuread_service_principal.service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.app_reg_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [github_actions_variable.application_id_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_actions_variable.subscription_id_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_actions_variable.tenant_id_variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environments"></a> [environments](#input\_environments) | List of project environments | `set(string)` | <pre>[<br>  "dev",<br>  "prod"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Azure resources | `string` | `"NorthEurope"` | no |
| <a name="input_location_code"></a> [location\_code](#input\_location\_code) | Location code of the Azure resources. Used for interpolation | `string` | `"neu"` | no |
| <a name="input_project_code"></a> [project\_code](#input\_project\_code) | Code of the project. Used for interpolation | `string` | n/a | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of the repository | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->