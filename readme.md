# Azure Web App Module

## Overview
This Terraform module creates an Azure Web App with configurable settings and tags. It also provisions the App Service Plan required for the Web App.

## Requirements
- Azure Subscription

## Variables

| Name                  | Description                                              | Type   | Default  | Validation                                           |
|-----------------------|----------------------------------------------------------|--------|----------|------------------------------------------------------|
| app_name              | The name of the web app. Must follow the format 'owner-product-application-location-web-app'. | string | N/A      | Must match regex ^${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-web-app$ |
| location              | Azure location. Must be one of 'East US', 'West US', or 'Central US'. | string | East US  | Must be one of 'East US', 'West US', 'Central US'    |
| sku_tier              | The SKU tier for the App Service Plan.                   | string | Standard | N/A                                                  |
| sku_size              | The SKU size for the App Service Plan.                   | string | S1       | N/A                                                  |
| resource_group_name   | Name of the resource group.                              | string | N/A      | N/A                                                  |
| app_settings          | Map of app settings for the web app.                    | map    | {}       | N/A                                                  |
| tags                  | A map of tags to apply to resources. Must include 'product', 'application', and 'owner' keys. | map    | { product = "default-product" } | Must include 'product', 'application', 'owner' keys |

## Usage
```hcl
module "web_app" {
  source              = "app.terraform.io/shiazy18/web-app/azurerm"
  version             = "1.0.0"

  location            = "East US"
  sku_tier            = "PremiumV2"
  sku_size            = "P1v2"
  app_settings        = { "WEBSITE_RUN_FROM_PACKAGE" = "1" }
  tags                = { product = "webapp-product", application = "portal", owner = "teamA" }
}
