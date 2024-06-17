# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.108.0"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}

variable "AZURE_RESOURCE_GROUP" {
  type = string
}

variable "AZURE_REGION" {
  type    = string
  default = "westus"
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = var.AZURE_RESOURCE_GROUP
  location = var.AZURE_REGION
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-${random_integer.ri.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  https_only          = true
  app_settings = {
    WEBSITES_PORT = "1880"
  }
  site_config {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack {
      docker_image_name   = "nodered/node-red:3.1.10-14"
      docker_registry_url = "https://index.docker.io"
    }
  }
}
