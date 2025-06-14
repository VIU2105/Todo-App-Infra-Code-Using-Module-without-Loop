variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
  
}

variable "nic_location" {
  description = "Location of the Network Interface"
  type        = string
  
}

variable "nic_rg_name" {
  description = "Resource Group Name for the Network Interface"
  type        = string
  
}

variable "subnet_id" {
  description = "ID of the Subnet to which the Network Interface will be attached"
  type        = string
  
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string  
}

variable "vm_username" {
  description = "Username for the virtual machine"
  type        = string
  
}

variable "vm_password" {
  description = "Password for the virtual machine"
  type        = string
  sensitive   = true
}
variable "publisher" {
  description = "Publisher of the OS image"
  type        = string
}
variable "offer" {
  description = "Offer of the OS image"
  type        = string
}
variable "sku" {
  description = "SKU of the OS image"
  type        = string
}
variable "os_version" {
  description = "Version of the OS image"
  type        = string
}

variable "ip_address1" {
  description = "IP address of the virtual machine"
  type        = string
}

variable "frontend_ip_address" {
    description = "Frontend IP address of the virtual machine"
  type        = string
  
}

variable "install_nginx" {
  description = "Whether to install Nginx on the VM"
  type        = bool
  default     = false
}