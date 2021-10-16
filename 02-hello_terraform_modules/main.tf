provider "azurerm" {
    features { }
}

module "distributed_storage" {
    for_each = toset(["eastus2", "westus2","eastus"])
    source = "./regional_storage"
    prefix = var.prefix
    location = each.key
}