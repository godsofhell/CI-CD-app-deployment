variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "webapp_name" {
  description = "The name of the web app"
  type        = string
}

variable "service_details" {
  description = "Details of the service plan, SKU, and OS"
  type        = list(string)
}