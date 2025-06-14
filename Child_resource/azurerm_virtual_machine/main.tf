resource "azurerm_network_interface" "nic_todo_app" {
  name                = var.nic_name
  location            = var.nic_location    
  resource_group_name = var.nic_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = var.ip_address1
  }
}

resource "azurerm_linux_virtual_machine" "vm_todo_app" {
  name                = var.vm_name
  resource_group_name = var.nic_rg_name
  location            = var.nic_location
  size                = var.vm_size
  admin_username      = var.vm_username
  admin_password = var.vm_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic_todo_app.id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
}
# resource "null_resource" "ngix"{
#   count = var.install_nginx ? 1 : 0
#   depends_on = [ azurerm_linux_virtual_machine.vm_todo_app ]
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt update -y",
#       "sudo apt install nginx -y",
#       "sudo systemctl enable nginx",
#       "sudo systemctl start nginx"
#     ]

#     connection {
#       type     = "ssh"
#       user     = var.vm_username
#       password = var.vm_password
#       host     = var.frontend_ip_address
#     }
#   }
# }




