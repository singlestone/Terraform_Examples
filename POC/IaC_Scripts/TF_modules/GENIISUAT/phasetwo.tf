resource "null_resource" "GENIISUAT_WEB_CONFIG" {
  depends_on = ["null_resource.GENIIS_CONFIG"]

  connection {
    type     = "winrm"
    user     = "${var.Conuser}"
    password = "${var.Conpassword}"
    host     = "172.18.96.190"
    insecure = "false"
    timeout  = "90m"
  }

  provisioner "file" {
    source      = "IaC_Scripts\\chef\\cookbooks_GENIISUAT\\"
    destination = "C:\\chef\\cookbooks\\"
  }

  provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\geniisuat\\geniisuat_solo.rb"]
  }

  provisioner "file" {
    source      = "IaC_Artifacts\\Data_Drive_GENIISUAT\\Keepalives\\connect.acme.local"
    destination = "D:\\Keepalives\\connect.acme.local"
  }

  provisioner "file" {
    source      = "IaC_Artifacts\\Data_Drive_GENIISUAT\\Websites\\connect.acme.local.zip"
    destination = "D:\\Terraform\\archive\\connect.acme.local.zip"
  }

  provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\connect.acme.local\\connect_acme_local_solo.rb"]
  }
}
