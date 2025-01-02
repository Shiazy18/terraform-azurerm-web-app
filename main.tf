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