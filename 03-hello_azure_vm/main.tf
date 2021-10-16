provider "azurerm" {
    features { }
}

# resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-${var.prefix}-${var.location}"
    location = var.location
}

locals {
  prefix = var.prefix
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# virtual network
resource "azurerm_virtual_network" "vn" {
    name     = "vn-${local.prefix}-${local.location}"
    location = local.location
    address_space = [ "10.0.0.0/16"]
    resource_group_name = local.resource_group_name
}

# subnet
resource "azurerm_subnet" "sn" {
    name     = "internal"
    address_prefixes = [ "10.0.1.0/24"]
    resource_group_name = local.resource_group_name
    virtual_network_name = azurerm_virtual_network.vn.name
}
output "subnet_id" {
  value = azurerm_subnet.sn.id
}


locals {
  subnet_id = azurerm_subnet.sn.id
}

# public IP address
resource "azurerm_public_ip" "ip" {
    name = "ip-${local.prefix}-${local.location}"
    location = local.location
    allocation_method = "Static"
    resource_group_name = local.resource_group_name
    domain_name_label = local.prefix
}

# network interface
resource "azurerm_network_interface" "nic" {
    name = "nic-${local.prefix}-${local.location}"
    location = local.location
    resource_group_name = local.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = local.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.ip.id
    }
}

# virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
    name = "vm-${local.prefix}-${local.location}"
    resource_group_name = local.resource_group_name
    location = local.location
    size = "Standard_B2s"
    admin_username = "azadmin"
    network_interface_ids = [ azurerm_network_interface.nic.id, ]
    
    admin_ssh_key {
      username = "azadmin"
      public_key = file("~/.ssh/id_rsa.pub")
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
    }

    os_disk {
      storage_account_type = "Standard_LRS"
      caching = "ReadWrite"
    }

    connection {
      host = "${local.prefix}.${local.location}.cloudapp.azure.com"
      user = self.admin_username
      type = "ssh"
      private_key = file("~/.ssh/id_rsa")
      agent = true
    }
    provisioner "remote-exec" {
      inline = [
        "sudo apt-get install -y nginx",
      ]      
    }

}