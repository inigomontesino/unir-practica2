/*
Fichero main:
  * terraform provider de azure con la versión fija.
  * azurerm_resource_group.prac2: Resource group sobre el que se crearán los recursos.
  * azurerm_storage_account.stoAccount: Gestión del almacenamiento del grupo de recursos.
*/

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.98.0"
    }
  }
}

resource "azurerm_resource_group" "prac2" {
  name     = "prac2"
  location = var.location
}

resource "azurerm_storage_account" "stoAccount" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.prac2.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
