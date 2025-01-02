# variable "app_name" {
#   description = "The name of the web app. Must follow the format 'owner-product-application-location-web-app'."
#   type        = string
#   validation {
#     condition     = can(regex("^[a-zA-Z0-9]+-[a-zA-Z0-9]+-[a-zA-Z0-9]+-[a-zA-Z0-9]+-web-app$", var.app_name))
#     error_message = "The app name must follow the format 'owner-product-application-location-web-app' (e.g., teamA-productX-portal-EastUS-web-app)."
#   }
# }


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

variable "sku_tier" {
  description = "The SKU tier for the App Service Plan."
  type        = string
  default     = "Standard"
}

variable "sku_size" {
  description = "The SKU size for the App Service Plan."
  type        = string
  default     = "S1"
}

variable "tags" {
  description = "A map of tags to be applied to resources. Must include 'product', 'application', and 'owner' keys."
  type        = map(string)
  default     = { product = "default-product", application = "default-app", owner = "default-owner" }
  validation {
    condition     = contains(keys(var.tags), "product") && contains(keys(var.tags), "application") && contains(keys(var.tags), "owner")
    error_message = "Tags must include 'product', 'application', and 'owner' keys."
  }
}

variable "enable_app_insights" {
  description = "Enable Application Insights."
  type        = bool
  default     = false
}

variable "enable_autoscale" {
  description = "Enable Auto Scaling."
  type        = bool
  default     = false
}

variable "enable_deployment_slot" {
  description = "Enable Deployment Slot for Blue-Green Deployment."
  type        = bool
  default     = false
}

# variable "sku_tier" {
#   description = "Tier of the App Service Plan."
#   type        = string
#   default     = "Standard"
# }

# variable "sku_size" {
#   description = "Size of the App Service Plan."
#   type        = string
#   default     = "S1"
# }
