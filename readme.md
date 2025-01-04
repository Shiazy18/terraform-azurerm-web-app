# Azure Web App Module

## Overview
This Terraform module creates an Azure Web App with configurable settings and tags. It also provisions the App Service Plan required for the Web App. For latest version please check from https://app.terraform.io/app/shiazy18/registry/modules/private/shiazy18/web-app/azurerm/1.0.0

## Requirements
- Azure Subscription

## Variables

| Name                  | Description                                              | Type   | Default  | Validation                                           |
|-----------------------|----------------------------------------------------------|--------|----------|------------------------------------------------------|
| app_name              | The name of the web app. Must follow the format 'owner-product-application-location-web-app'. | string | N/A      | Must match regex ^${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-web-app$ |
| location              | Azure location. Must be one of 'East US', 'West US', or 'Central US'. | string | East US  | Must be one of 'East US', 'West US', 'Central US'    |
| enable_app_insights   | Enable Application Insights.                             | bool   | false    | N/A                                                  |
| enable_autoscale      | Enable Auto Scaling for the App Service Plan.             | bool   | false    | N/A                                                  |
| enable_deployment_slot| Enable Deployment Slot for Blue-Green Deployments.        | bool   | false    | N/A                                                  |
| sku_tier              | App Service Plan tier.                                    | string | Standard | N/A                                                  |
| sku_size              | App Service Plan size.                                    | string | S1       | N/A                                                  |
| autoscale_default_capacity | Default capacity for autoscaling.                     | number | 1        | N/A                                                  |
| autoscale_min_capacity     | Minimum capacity for autoscaling.                     | number | 1        | N/A                                                  |
| autoscale_max_capacity     | Maximum capacity for autoscaling.                     | number | 5        | N/A                                                  |
| autoscale_time_grain       | Time grain for autoscale metric.                      | string | PT1M     | N/A                                                  |
| autoscale_statistic        | Statistic for autoscale metric.                       | string | Average  | N/A                                                  |
| autoscale_operator         | Comparison operator for autoscale.                    | string | GreaterThan | N/A                                              |
| autoscale_threshold        | Threshold for autoscale.                              | number | 70       | N/A                                                  |
| autoscale_time_window      | Time window for autoscale metric.                     | string | PT5M     | N/A                                                  |
| autoscale_direction        | Scale direction (Increase/Decrease).                  | string | Increase | N/A                                                  |
| autoscale_type             | Scale type (ChangeCount/ExactCount).                  | string | ChangeCount | N/A                                              |
| autoscale_value            | Scale value.                                          | number | 1        | N/A                                                  |
| autoscale_cooldown         | Cooldown period in seconds.                           | number | 300      | N/A                                                  |


## Usage
```hcl
module "web_app" {
  source              = "app.terraform.io/shiazy18/web-app/azurerm"
  version             = "1.0.0"

  location            = "East US"
  app_settings        = { "WEBSITE_RUN_FROM_PACKAGE" = "1" }
  enable_app_insights = true
  enable_autoscale    = true
  enable_deployment_slot = true
  tags                = { product = "webapp-product", application = "portal", owner = "teamA" }
}
