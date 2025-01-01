resource "azurerm_resource_group" "rg" {
  name     = "${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_app_service" "webapp" {
  name                = "${var.tags["owner"]}-${var.tags["product"]}-${var.tags["application"]}-${var.location}-web-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = var.app_service_plan_id

  site_config {
    always_on = true
  }

  app_settings = var.app_settings
}