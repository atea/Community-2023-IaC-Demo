variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group to put network resources in"
}

variable "name" {
  type        = string
  description = "Name for Virtual Machine"
}

variable "enable_public_ip" {
  type        = bool
  default     = false
  description = "Enable Public IP on Virtual Machine"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for network interface"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags to apply to all resources"
}

variable "vm_size" {
  type        = string
  default     = "Standard_F1s"
  description = "Size/SKU for Virtual Machine"
}

variable "admin_username" {
  type        = string
  default     = "demo"
  description = "Admin username for Virtual Machine"
}