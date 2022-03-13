/*
Fichero de red.
    * module.network: Módulo que crea la red.
*/

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.prac2.name
  address_spaces      = [var.network_cidr]
  subnet_prefixes     = [var.subnet_1_cidr, var.subnet_2_cidr, var.subnet_3_cidr]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  tags = {
    environment = "p2"
  }

  depends_on = [azurerm_resource_group.prac2]
}
