variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group to put network resources in"
}

variable "name" {
  type        = string
  description = "Name for Virtual Network"
}

variable "address_space" {
  type        = string
  description = "Address Space for Virtual Network"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Tags to apply to all resources"
}