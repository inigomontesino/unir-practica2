/*
Fichero para definir el servidor NFS.
    * azurerm_linux_virtual_machine.nfs: Definición de la maquina virtual.
    * azurerm_network_interface.nfs_nic: Interfaz de red con IP interna fija.
    * azurerm_public_ip.nfs_pub_ip: Ip pública asociada al interfaz de red.
    * azurerm_private_dns_a_record.nfs: Registro DNS interno.
    * azurerm_network_interface_security_group_association.associate_nfs_ports: Asociación del grupo de seguridad con la maquina virtual.
*/

resource "azurerm_linux_virtual_machine" "nfs" {
  name                            = "nfs.dns.local"
  resource_group_name             = azurerm_resource_group.prac2.name
  location                        = azurerm_resource_group.prac2.location
  size                            = var.small_size
  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.nfs_nic.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = var.instance_sku
    product   = var.instance_sku
    publisher = var.instance_pub
  }

  source_image_reference {
    publisher = var.instance_pub
    offer     = var.instance_sku
    sku       = var.instance_sku
    version   = var.instance_version
  }
  depends_on = [azurerm_network_interface.nfs_nic]

}

resource "azurerm_network_interface" "nfs_nic" {
  name                = "nfs"
  location            = azurerm_resource_group.prac2.location
  resource_group_name = azurerm_resource_group.prac2.name
  ip_configuration {
    private_ip_address            = "10.0.0.11"
    name                          = "nfs_ip"
    subnet_id                     = module.network.vnet_subnets[0]
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.nfs_pub_ip.id
  }
  depends_on = [azurerm_public_ip.nfs_pub_ip]
}

resource "azurerm_public_ip" "nfs_pub_ip" {
  name                = "nfs_pub_ip"
  domain_name_label   = join("-", ["nfs", var.domain_suffix])
  location            = azurerm_resource_group.prac2.location
  resource_group_name = azurerm_resource_group.prac2.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_private_dns_a_record" "nfs" {
  name                = "nfs"
  zone_name           = azurerm_private_dns_zone.prac2.name
  resource_group_name = azurerm_resource_group.prac2.name
  ttl                 = 300
  records             = [azurerm_network_interface.nfs_nic.private_ip_address]
  depends_on          = [azurerm_network_interface.nfs_nic]
}

resource "azurerm_network_interface_security_group_association" "associate_nfs_ports" {
  network_interface_id      = azurerm_network_interface.nfs_nic.id
  network_security_group_id = module.network-security-group-nfs-int.network_security_group_id
}
