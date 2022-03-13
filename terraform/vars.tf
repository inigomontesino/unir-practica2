/*
Fichero de variables.
    * network_cidr: Rango de red.
    * subnet_1_cidr: Rango de red de la primera zona.
    * subnet_2_cidr: Rango de red de la primera zona.
    * subnet_3_cidr: Rango de red de la tercera zona.
    * medium_size: Tamaño medio seleccionado para de la maquina.
    * small_size: Tamaño pequeño seleccionado para de la maquina.
    * instance_sku: SKU
    * instance_pub: Publisher
    * instance_version: Versión.
    * domain_suffix: Sufijo utilizado para el DNS que se crea en Azure.
*/

variable "network_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet_2_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "subnet_3_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "medium_size" {
  type        = string
  description = "Tamaño de la máquina virtual"
  default     = "Standard_F2s_v2" # 4 GB, 2 CPU
}

variable "small_size" {
  type        = string
  description = "Tamaño de la máquina virtual"
  default     = "Standard_D1_v2" # 3.5 GB, 1 CPU
}

variable "instance_sku" {
  type        = string
  description = "Instance SKU, offer"
  default     = "centos-8-stream-free"
}

variable "instance_pub" {
  type        = string
  description = "Instance Publisher"
  default     = "cognosys"
}

variable "instance_version" {
  type        = string
  description = "Instance version"
  default     = "1.2019.0810"
}

variable "domain_suffix" {
  type        = string
  description = "Sufijo del dominio"
  default     = "imv"
}