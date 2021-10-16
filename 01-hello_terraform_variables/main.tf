provider "azurerm" {
    features { }
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.prefix}"
    location = var.location
}