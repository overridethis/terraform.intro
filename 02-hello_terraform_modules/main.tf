provider "azurerm" {
    features { }
}

locals {
  prefix = var.prefix
  location = var.location
}

resource "azurerm_resource_group" "rg" {
    name     = "rg-${local.prefix}-${local.location}"
    location = var.location
}

resource "azurerm_storage_account" "storage" {
    name                     = "st${local.prefix}${local.location}"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}

output "storage_name" {
    value = azurerm_storage_account.storage.name
}