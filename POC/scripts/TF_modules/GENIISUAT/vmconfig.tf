resource "vsphere_virtual_machine" "GENIISUAT" {

  name       = "kmxIISUAT01"
  folder     = "${var.VMFolder}"
  vcpu       = 2
  memory     = 4096
  datacenter = "${var.datacenter}"

  network_interface {
    label              = "${var.networklabel}"
    ipv4_address       = "172.18.96.189"
    ipv4_prefix_length = "${var.prefix_length}"
    ipv4_gateway       = "${var.gateway}"
  }

  dns_servers = "${var.dns_servers}"

  disk {
    datastore = "${var.datastore}"
    template  = "${var.template}"
    type      = "thin"
  }

  disk {
    datastore = "${var.datastore}"
    name      = "DataDrive"
    type      = "thin"
    size      = "100"
  }
}
