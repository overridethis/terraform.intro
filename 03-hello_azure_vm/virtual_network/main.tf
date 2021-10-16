# virtual network
resource "azurerm_virtual_network" "vn" {
    name     = "vn-${var.prefix}-${var.location}"
    location = var.location
    address_space = [ "10.0.0.0/16"]
    resource_group_name = var.resource_group_name
}

# subnet
resource "azurerm_subnet" "sn" {
    name     = "internal"
    address_prefixes = [ "10.0.1.0/24"]
    resource_group_name = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vn.name
}

output "subnet_id" {
    value = azurerm_subnet.sn.id
}