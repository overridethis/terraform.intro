
# public IP address
resource "azurerm_public_ip" "ip" {
    name = "ip-${var.prefix}-${var.location}"
    location = var.location
    allocation_method = "Static"
    resource_group_name = var.resource_group_name
    domain_name_label = var.prefix
}

# network interface
resource "azurerm_network_interface" "nic" {
    name = "nic-${var.prefix}-${var.location}"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
      name = "internal"
      subnet_id = var.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id = azurerm_public_ip.ip.id
    }
}

# virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
    name = "vm-${var.prefix}-${var.location}"
    resource_group_name = var.resource_group_name
    location = var.location
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
      host = "${var.prefix}.${var.location}.cloudapp.azure.com"
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