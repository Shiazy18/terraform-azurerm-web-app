
resource "azurerm_resource_group" "rg" {
  name     = "${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_app_service_plan" "app_plan" {
  name                = "${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-app-plan"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
  tags = var.tags
}

resource "azurerm_app_service" "webapp" {
  name                = "${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-web-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    always_on = true
  }

  app_settings = var.app_settings
}

resource "azurerm_application_insights" "app_insights" {
  count               = var.enable_app_insights ? 1 : 0
  name                = "${var.tags["owner"]}-${var.tags["application"]}-ai"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_monitor_autoscale_setting" "autoscale" {
  count               = var.enable_autoscale ? 1 : 0
  name                = "autoscale-setting"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  target_resource_id  = azurerm_app_service_plan.app_plan.id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.app_plan.id
        time_grain         = "PT1M"
        statistic          = "Average"
        operator           = "GreaterThan"
        threshold          = 70
        time_aggregation   = "Average" # <- Add this line
        time_window        = "PT5M"    # <- And this line
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT5M"
      }
    }

  }
}

resource "azurerm_app_service_slot" "staging" {
  count               = var.enable_deployment_slot ? 1 : 0
  name                = "staging"
  app_service_name    = azurerm_app_service.webapp.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    always_on = true
  }

  app_settings = merge(
    var.app_settings,
    {
      "SLOT_SETTING" = "true"
    }
  )
}
