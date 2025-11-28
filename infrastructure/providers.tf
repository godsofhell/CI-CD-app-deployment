terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}

provider "azurerm" {
  features {}
  
  # Authentication credentials are provided via environment variables:
  # - ARM_CLIENT_ID
  # - ARM_CLIENT_SECRET
  # - ARM_TENANT_ID
  # - ARM_SUBSCRIPTION_ID
  # 
  # These are automatically set by GitHub Actions from secrets
  # For local development, set these in your shell or use Azure CLI authentication
}
