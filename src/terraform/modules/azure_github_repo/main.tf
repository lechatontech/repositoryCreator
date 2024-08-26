terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

data "azurerm_client_config" "current" {
}

data "github_repository" "repository" {
  name = var.repository_name
}

resource "azuread_application_registration" "app_registration" {
  for_each     = var.environments
  display_name = "apprg-${var.project_code}-${each.value}"
  description  = "App Registration for project ${var.project_code} ${each.value} environment"
}

resource "azuread_service_principal" "service_principal" {
  for_each  = var.environments
  client_id = azuread_application_registration.app_registration[each.value].client_id
}

resource "azurerm_resource_group" "resource_group" {
  for_each = var.environments
  name     = "rg-${var.project_code}-${var.location_code}-${each.value}"
  location = var.location
  tags = {
    project       = var.project_code
    repository    = var.repository_name
    creation_date = formatdate("YYYY/MM/DD", timestamp())
    environment   = each.value
  }
  lifecycle {
    ignore_changes = [tags.creation_date]
  }
}

resource "azurerm_role_assignment" "app_reg_role" {
  for_each             = var.environments
  scope                = azurerm_resource_group.resource_group[each.value].id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.service_principal[each.value].object_id
}

resource "azuread_application_federated_identity_credential" "service_principal_credential" {
  for_each       = var.environments
  application_id = azuread_application_registration.app_registration[each.value].id
  display_name   = each.value == "dev" ? "github-repo-${var.project_code}-dev" : "github-repo-${var.project_code}-main"
  description    = each.value == "dev" ? "Github repo ${var.project_code} dev branch" : "Github repo ${var.project_code} main branch"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = each.value == "dev" ? "repo:${data.github_repository.repository.full_name}:ref:refs/heads/dev" : "repo:${data.github_repository.repository.full_name}:ref:refs/heads/main"
}

resource "azuread_application_federated_identity_credential" "service_principal_credential_pr" {
  application_id = azuread_application_registration.app_registration["dev"].id
  display_name   = "github-repo-${var.project_code}-pr"
  description    = "Github repo ${var.project_code} Pull Request"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${data.github_repository.repository.full_name}:pull_request"
}

resource "github_actions_secret" "application_id_secret" {
  for_each        = var.environments
  repository      = data.github_repository.repository.name
  secret_name     = "${upper(each.value)}_AZURE_APPLICATION_ID"
  plaintext_value = azuread_application_registration.app_registration[each.value].client_id
}

resource "github_actions_secret" "tenant_id_secret" {
  repository      = data.github_repository.repository.name
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

resource "github_actions_secret" "subscription_id_secret" {
  repository      = data.github_repository.repository.name
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_client_config.current.subscription_id
}


