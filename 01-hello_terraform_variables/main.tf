provider "azurerm" {
    features { }
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-demo-eastus2"
    location = "eastus2"
}