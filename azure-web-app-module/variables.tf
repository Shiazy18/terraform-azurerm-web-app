variable "app_name" {
  description = "The name of the web app. Must start with a letter and be between 3 and 24 characters."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{2,23}$", var.app_name))
    error_message = "The app name must start with a letter, can contain letters, numbers, and hyphens, and must be between 3 and 24 characters."
  }
}

variable "location" {
  description = "Azure location where the resources will be created. Must be one of 'East US', 'West US', or 'Central US'."
  type        = string
  default     = "East US"
  validation {
    condition     = contains(["East US", "West US", "Central US"], var.location)
    error_message = "Location must be one of the following: 'East US', 'West US', 'Central US'."
  }
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
