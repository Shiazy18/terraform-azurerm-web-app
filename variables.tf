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

variable "sku_tier" {
  description = "Tier of the App Service Plan."
  type        = string
  default     = "Standard"
}

variable "sku_size" {
  description = "Size of the App Service Plan."
  type        = string
  default     = "S1"
}

variable "autoscale_default_capacity" {
  description = "Default capacity for autoscaling."
  type        = number
  default     = 1
}

variable "autoscale_min_capacity" {
  description = "Minimum capacity for autoscaling."
  type        = number
  default     = 1
}

variable "autoscale_max_capacity" {
  description = "Maximum capacity for autoscaling."
  type        = number
  default     = 3
}

variable "autoscale_metric_name" {
  description = "Metric to trigger autoscale."
  type        = string
  default     = "CpuPercentage"
}

variable "autoscale_time_grain" {
  description = "Time grain for metric evaluation."
  type        = string
  default     = "PT1M"
}

variable "autoscale_statistic" {
  description = "Statistic for autoscale metric."
  type        = string
  default     = "Average"
}

variable "autoscale_operator" {
  description = "Operator for autoscale rule."
  type        = string
  default     = "GreaterThan"
}

variable "autoscale_threshold" {
  description = "Threshold for autoscale rule."
  type        = number
  default     = 70
}

variable "autoscale_time_aggregation" {
  description = "Time aggregation for autoscale rule."
  type        = string
  default     = "Average"
}

variable "autoscale_time_window" {
  description = "Time window for metric evaluation."
  type        = string
  default     = "PT5M"
}

variable "autoscale_direction" {
  description = "Direction of scaling (Increase/Decrease)."
  type        = string
  default     = "Increase"
}

variable "autoscale_type" {
  description = "Type of scaling (ChangeCount/ExactCount/PercentChange)."
  type        = string
  default     = "ChangeCount"
}

variable "autoscale_value" {
  description = "Value by which to scale."
  type        = number
  default     = 1
}

variable "autoscale_cooldown" {
  description = "Cooldown period before scaling again."
  type        = string
  default     = "PT5M"
}

