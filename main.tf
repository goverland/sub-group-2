terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.103.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "hubsaterraformbackend"
    container_name       = "hubterraformbackend"
    key                  = "sub-2-tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

module "app1" {
  source = "git::https://github.com/goverland/terraform-base.git//modules/app1"
  customer_names = var.customer_names
  subscription_name = var.subscription_group_name
  providers = {
    azurerm = azurerm
  }
  # or specify a branch, tag, or commit
  # source = "git::https://github.com/your-org/base-module-repo.git//modules/app1?ref=main"
 
}

module "app2" {
  source = "git::https://github.com/goverland/terraform-base.git//modules/app2"
  customer_names = var.customer_names
  subscription_name = var.subscription_group_name
  providers = {
    azurerm = azurerm
  }
}
