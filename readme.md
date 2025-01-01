# Azure Web App Module

## Overview
This Terraform module creates an Azure Web App with configurable settings.

## Requirements
- Azure Resource Group
- Azure App Service Plan

## Variables

| Name                  | Description                                              | Type   | Default  | Validation                                           |
|-----------------------|----------------------------------------------------------|--------|----------|------------------------------------------------------|
| app_name              | The name of the web app. Must start with a letter and be between 3 and 24 characters. | string | N/A      | Must match regex ^[a-zA-Z][a-zA-Z0-9-]{2,23}$         |
| location              | Azure location. Must be one of 'East US', 'West US', or 'Central US'. | string | East US  | Must be one of 'East US', 'West US', 'Central US'    |
| resource_group_name   | Name of the resource group.                              | string | N/A      | N/A                                                  |
| app_service_plan_id   | The ID of the App Service Plan.                          | string | N/A      | N/A                                                  |
| app_settings          | Map of app settings for the web app.                    | map    | {}       | N/A                                                  |

## Usage
```hcl
module "web_app" {
  source              = "app.terraform.io/Shiazy18/azure-webapp-module/azurerm"
  version             = "1.0.0"

  resource_group_name = "myResourceGroup"
  app_name            = "myWebApp"
  location            = "East US"
  app_service_plan_id = azurerm_app_service_plan.example.id
  app_settings        = { "WEBSITE_RUN_FROM_PACKAGE" = "1" }
}
```
