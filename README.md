# Todo-App-Infra-Code-Using-Module-without-Loop
📦 Terraform Infrastructure – Azure Monolithic ToDo App (Frontend + Backend + MySQL, No Loops) This Terraform project provisions the infrastructure for a monolithic ToDo application hosted on Azure, structured into modular components without using loops (count, for_each, etc.).

✅ Features
🚀 Frontend and Backend hosted on separate Azure VMs

🛢️ MySQL Database provisioned via Azure Database for MySQL (Single Server or Flexible Server)

🌐 Virtual Network with subnet isolation between app layers

🔐 Network Security Groups (NSGs) for access control

❌ No Azure Storage Accounts used

📦 Each resource group is declared manually via modules (no iteration logic)

🔧 Components Provisioned
Module	Resource Summary
network	VNet, 2 subnets (frontend & backend), NSGs
frontend_vm	Linux VM (e.g., Ubuntu with Nginx)
backend_vm	Linux VM (e.g., Python Flask)
mysql	Azure Database for MySQL (DB + firewall)
