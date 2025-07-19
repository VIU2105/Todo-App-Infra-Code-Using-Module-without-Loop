terraform {
  required_providers {
    azurerm ={
        source = "hashicorp/azurerm"
        version = "4.36.0"
    }
  }
  required_version = ">= 1.11.2"
}

provider "azurerm" {
  features {}
  subscription_id = "b30e900a-5ee7-4ea7-b027-4ea34f083e58"
}