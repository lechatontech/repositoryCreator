terraform {
  required_version = ">= 1.0.0"

  # backend "azurerm" {
  # }

  required_providers {
    azurerm = {
      version = ">= 3.100.0, < 4.0.0"
    }

    azuread = {
      version = ">= 2.48.0, < 3.0.0"
    }

    github = {
      source  = "integrations/github"
      version = ">= 6.2.0, < 7.0.0"
    }
  }

}
