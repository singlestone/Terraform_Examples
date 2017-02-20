resource "vsphere_virtual_machine" "GENAPPUAT" {
  name       = "kmxAPPUAT01"
  folder     = "UAT-Stack"
  vcpu       = 2
  memory     = 4096
  datacenter = "WC_Test-01"
  resource_pool = "Test01/Resources"
  
	network_interface {
		label = "Guest_Network.96"
		ipv4_address = "172.18.96.189"
		ipv4_prefix_length = 24
		ipv4_gateway = "172.18.100.1"	
	}

	dns_servers = ["172.18.100.45", "172.18.100.46"]

	disk {
		datastore = "7001-LAB-VMFS1"
		template = "Templates/window2012r2"
		type = "thin"
		size = "100"
	}
	
	disk {
		datastore = "7001-LAB-VMFS1"
		type = "thin"
		size = "100"
	}
}