terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }
  }

  required_version = ">= 0.12"
}