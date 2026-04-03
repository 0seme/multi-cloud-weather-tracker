resource "azurerm_resource_group" "dr" {
  name     = var.azure_resource_group_name
  location = var.azure_location

  tags = {
    Project     = "multi-cloud-weather-tracker"
    Environment = "dr"
  }
}

resource "azurerm_storage_account" "dr" {
  name                     = var.azure_storage_account_name
  resource_group_name      = azurerm_resource_group.dr.name
  location                 = azurerm_resource_group.dr.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    Project     = "multi-cloud-weather-tracker"
    Environment = "dr"
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.dr.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../app/index-azure.html"
  content_type           = "text/html"
}