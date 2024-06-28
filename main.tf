terraform {
  required_version = ">=1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.43.0"
    }
  }
  cloud {
    organization = "JafercineSpace"

    workspaces {
      name = "TerraformCI"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false

}

resource "azurerm_resource_group" "rg" {
  name     = "811-092f5b4b-provide-continuous-delivery-with-gith"
  location = "southcentralus"

}

resource "azurerm_storage_account" "storage" {
  name                     = "stg${random_string.uniquestring.result}"
  location                 = azurerm_resource_group.rg.location
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"

}
