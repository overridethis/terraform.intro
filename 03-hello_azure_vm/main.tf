provider "azurerm" {
    features { }
}

# resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.prefix}-${var.location}"
    location = var.location
}

# virtual network
module "virtual_network" {
  source = "./virtual_network"
  location = var.location
  prefix = var.prefix
  resource_group_name = azurerm_resource_group.rg.name  
}

# webserver
module "webserver" {
  source = "./webserver"
  location = var.location
  prefix = var.prefix
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.virtual_network.subnet_id
}

# webserver
module "webserver_01" {
  source = "./webserver"
  location = "westus2"
  prefix = "${var.prefix}01"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = module.virtual_network.subnet_id
}