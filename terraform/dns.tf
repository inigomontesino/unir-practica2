/*
Fichero para la zona DNS interna.
    * azurerm_private_dns_zone.prac2: Definición de la zona DNS privada.
*/

resource "azurerm_private_dns_zone" "prac2" {
  name                = "dns.local"
  resource_group_name = azurerm_resource_group.prac2.name
}