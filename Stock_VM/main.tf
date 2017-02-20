provider "vsphere" {
  user                 = "${var.VMuser}"
  password             = "${var.VMpassword}"
  vsphere_server       = "ENTVCST02.kmxtest.local"
  allow_unverified_ssl = "true"
}

# Create a folder
resource "vsphere_folder" "UAT-Stack" {
  datacenter = "WC_Test-02"
  path       = "UAT-Stack"
}

resource "vsphere_virtual_machine" "GEN" {
  name       = "dmxIISUAT01"
  folder     = "UAT-Stack"
  vcpu       = 2
  memory     = 4096
  datacenter = "WC_Test-02"
  #resource_pool = "Test02/Resources"
  
  
 network_interface {
	label = "VM Network"
	ipv4_address = "172.18.96.190"
	ipv4_prefix_length = 24
	ipv4_gateway = "172.18.100.1"	
 }

  dns_servers = ["172.18.100.45", "172.18.100.46"]

  disk {
    datastore = "WCESXLAB01-TIER3-01-MD3220"
    template  = "Templates/Windows2012r2"
    type      = "thin"
  }

  disk {
    datastore = "WCESXLAB01-TIER3-01-MD3220"
	name	  = "DataDrive"
    type      = "thin"
    size      = "100"
  }
}
