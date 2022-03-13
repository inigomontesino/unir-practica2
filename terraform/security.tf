/*
Fichero de grupos de seguridad.
    * module.network-security-group-nfs-int: Módulo de grupo de seguridad
            para abrir los puertos necesarios
            para el servidor NFS.
    * module.network-security-group-k8s-int: Módulo de grupo de seguridad
            para abrir los puertos necesarios
            para los nodos de kubernetes.
*/

module "network-security-group-nfs-int" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.prac2.name
  security_group_name   = "NFS"
  source_address_prefix = [var.network_cidr]
  custom_rules = [
    {
      name                   = "myssh"
      priority               = 200
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "*"
      description            = "SSH_PUB"
    },
    {
      name                   = "2049_tcp"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "2049"
      source_address_prefix  = var.network_cidr
      description            = ""
    },
    {
      name                   = "2049_udp"
      priority               = 202
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "udp"
      source_port_range      = "*"
      destination_port_range = "2049"
      source_address_prefix  = var.network_cidr
      description            = ""
    },
  ]
  depends_on = [azurerm_resource_group.prac2]
}

module "network-security-group-k8s-int" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.prac2.name
  security_group_name   = "K8S"
  source_address_prefix = [var.network_cidr]
  custom_rules = [
    {
      name                   = "myssh"
      priority               = 200
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "*"
      description            = "SSH_PUB"
    },
    {
      name                   = "6443_tcp"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "6443"
      source_address_prefix  = var.network_cidr
      description            = "KubernetesAPIServer"
    },
    {
      name                   = "2379_udp"
      priority               = 202
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "udp"
      source_port_range      = "*"
      destination_port_range = "2379"
      source_address_prefix  = var.network_cidr
      description            = "etcdserverclientAPI"
    },
    {
      name                   = "2380_tcp"
      priority               = 203
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "2380"
      source_address_prefix  = var.network_cidr
      description            = "etcdserverclientAP"
    },
    {
      name                   = "10250_tcp"
      priority               = 204
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "10250"
      source_address_prefix  = var.network_cidr
      description            = "KubeletAPI"
    },
    {
      name                   = "10251_tcp"
      priority               = 205
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "10251"
      source_address_prefix  = var.network_cidr
      description            = "kubescheduler"
    },
    {
      name                   = "10252_tcp"
      priority               = 206
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "10252"
      source_address_prefix  = var.network_cidr
      description            = "kubecontrollermanager"
    },
    {
      name                   = "10255_tcp"
      priority               = 207
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "10255"
      source_address_prefix  = var.network_cidr
      description            = "Statistics"
    },
    {
      name                   = "web"
      priority               = 208
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "30000-65000"
      source_address_prefix  = "*"
      description            = "HTTP_PUB"
    },
    {
      name                   = "webss"
      priority               = 209
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "tcp"
      source_port_range      = "*"
      destination_port_range = "80"
      source_address_prefix  = "*"
      description            = "HTTP_PUB"
    },
  ]
  depends_on = [azurerm_resource_group.prac2]
}
