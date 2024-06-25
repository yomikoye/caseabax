# Provider configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"  
    }
  }

  # Backend configuration for Azure Blob Storage
  backend "azurerm" {
    resource_group_name  = "infra-shared"
    storage_account_name = "koyecloud001" #update it to your tf state account and container
    container_name       = "tfstate"
    key                  = "abax/dev.tfstate"
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {}
}
