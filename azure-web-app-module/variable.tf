variable "app_name" {
  description = "The name of the web app."
  type        = string
}

variable "location" {
  description = "Azure location where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan."
  type        = string
}

variable "app_settings" {
  description = "A map of app settings for the web app."
  type        = map(string)
  default     = {}
}
