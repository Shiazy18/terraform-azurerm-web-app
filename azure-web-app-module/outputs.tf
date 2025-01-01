output "webapp_id" {
  value = azurerm_app_service.webapp.id
}

output "webapp_url" {
  value = azurerm_app_service.webapp.default_site_hostname
}