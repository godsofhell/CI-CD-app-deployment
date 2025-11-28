resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "serviceplan" {
  name                = var.service_details[0]
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  sku_name            = var.service_details[1]
  os_type             = var.service_details[2]
}

resource "azurerm_windows_web_app" "webapp" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.serviceplan.id

  site_config {
    always_on = false
    application_stack {
      current_stack = "dotnet"
      //version       = "10.0"
    }
  }
}