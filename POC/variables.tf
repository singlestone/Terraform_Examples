#vSphere Variables

variable "VMuser" {}

variable "VMpassword" {}

variable "datastore" {
  default = "WCESXLAB01-TIER3-01-MD3220"
}

variable "datacenter" {
  default = "WC_Test-02"
}

variable "VMFolder" {
  default = "UAT-Stack"
}

#Networking Variables

variable "networkLabel" {
  default = "VM Network"
}

variable "prefix_length" {
  default = 24
}

variable "gateway" {
  default = "172.18.100.1"
}

variable "dns_servers" {
  type    = "list"
  default = ["172.18.100.45", "172.18.100.46"]
}

variable "template" {
  default = "Templates/Windows2012r2"
}

#WinRM Variables

variable "Conuser" {}

variable "Conpassword" {}

variable "svnuser" {}

variable "svnpassword" {}
