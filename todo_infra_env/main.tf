module "resource_group" {
  source      = "../Child_resource/azurerm_resource_group"
  rg_name     = "rg_todo_app"
  rg_location = "centralindia"
}

module "virtual_network" {
  depends_on = [ module.resource_group ]
  source        = "../Child_resource/azurerm_virtual_network"
  vnet_rg_name  = "rg_todo_app"
  vnet_name     = "vnet_todo_app"
  vnet_location = "centralindia"
  address_space = ["22.0.0.0/16"]
}

# Dard 1- Do bar hum module call kar raha hai for Subnet create karne k liya
module "frontend-subnet" {
  depends_on = [ module.virtual_network ]
  source                  = "../Child_resource/azurerm_subnet"
  subnet_rg_name          = "rg_todo_app"
  vnet_name               = "vnet_todo_app"
  subnet_name             = "frontend-subnet"
  subnet_address_prefixes = ["22.0.0.0/24"]
}

module "backend-subnet" {
  depends_on = [ module.virtual_network ]
  source                  = "../Child_resource/azurerm_subnet"
  subnet_rg_name          = "rg_todo_app"
  vnet_name               = "vnet_todo_app"
  subnet_name             = "backend-subnet"
  subnet_address_prefixes = ["22.0.1.0/24"]
}

module "pip_frontend" {
  depends_on = [ module.resource_group ]
  source       = "../Child_resource/azurerm_pip"
  pip_name     = "ip_frontend"
  pip_location = "centralindia"
  pip_rg       = "rg_todo_app"

}

# output "vm_public_ip" {
#   value = module.pip_frontend.frontend_ip_add
# }

module "pip_backend" {
  depends_on = [ module.resource_group ]
  source       = "../Child_resource/azurerm_pip"
  pip_name     = "ip_backend"
  pip_location = "centralindia"
  pip_rg       = "rg_todo_app"

}

module "frontend_vm" {
  depends_on = [ module.frontend-subnet ]
  source = "../Child_resource/azurerm_virtual_machine"
  nic_name = "frontend-nic"
  nic_location = "centralindia"
  nic_rg_name = "rg_todo_app"
  #Subnet upar bana diya hai phr hardcoded kyu kr reh ho
  subnet_id = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Network/virtualNetworks/vnet_todo_app/subnets/frontend-subnet"
  vm_name = "frontend-vm-todo-app"
  vm_size = "Standard_B1s"
  # User id and Password hardcoded hai , secret scanning tool fail kr diya hai trufflehog
  vm_username = "adminuser"
  vm_password = "Admin@123456"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-jammy"
  sku = "22_04-lts"
  os_version = "latest"
  # Public IP address hardcoded hai 
  ip_address1 = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Network/publicIPAddresses/ip_frontend"
  frontend_ip_address = module.pip_frontend.frontend_ip_add # This used when we install nginx over VM through prvisioner
  install_nginx = true #count loop condition 
  
}

module "backend_vm" {
  depends_on = [ module.backend-subnet ]
  source = "../Child_resource/azurerm_virtual_machine"
  nic_name = "backend-nic"
  nic_location = "centralindia"
  nic_rg_name = "rg_todo_app"
  subnet_id = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Network/virtualNetworks/vnet_todo_app/subnets/backend-subnet"
  vm_name = "backend-vm-todo-app"
  vm_size = "Standard_B1s"
  vm_username = "adminuser"
  vm_password = "Admin@123456"
  publisher = "Canonical"
  offer = "0001-com-ubuntu-server-focal"
  sku = "20_04-lts"
  os_version = "latest"
  ip_address1 = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Network/publicIPAddresses/ip_backend"
  frontend_ip_address = module.pip_frontend.frontend_ip_add # This used when we install nginx over VM through prvisioner
  install_nginx = false #count loop condition 
}

module "sql_server" {
  depends_on = [ module.resource_group ]
  source = "../Child_resource/azurerm_SQL_Server"
  sql_server_name = "todo-app-db-server"
  sql_server_location = "centralindia"
  rg_name = "rg_todo_app"
  login_sql_server = "dbadmin"
  password_sql_server = "db@123456789"
}

module "sql_database" {
  depends_on = [ module.sql_server ]
  source = "../Child_resource/azurerm_SQL_Database"
  mysql_database = "todoappdatabase007"
  sql_server_id = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Sql/servers/todo-app-db-server"
}

module "nsg_frontend" {
  depends_on = [ module.resource_group , module.frontend_vm ]
  source = "../Child_resource/azurerm_NSG"
  nsg_name = "frontend_vm_nsg"
  location = "centralindia"
  resource_group_name = "rg_todo_app"
  nic_id = "/subscriptions/1212a59c-637f-45eb-8b74-8032483be797/resourceGroups/rg_todo_app/providers/Microsoft.Network/networkInterfaces/frontend-nic"
}