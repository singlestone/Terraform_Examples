resource "null_resource" "GENIISUAT_WEB_CONFIG" {
  depends_on = ["null_resource.GENIIS_CONFIG"]

  connection {
    type     = "winrm"
    user     = "${var.Conuser}"
    password = "${var.Conpassword}"
    host     = "172.18.96.189"
    insecure = "false"
    timeout  = "90m"
  }

  provisioner "file" {
    source      = "scripts\\remote_exec_GENIIS"
    destination = "C:\\Terraform\\script"
  }
 
  provisioner "local-exec" {
    command = "PSExec.exe \\\\172.18.96.189 -h -u ${var.Conuser} -p ${var.Conpassword} Powershell C:\\Terraform\\script\\Get-IaCFiles_GENIISUAT.ps1 -UserName ${var.svnuser} -Password ${var.svnpassword}"
  }

  provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\geniisuat\\geniisuat_solo.rb"]
  } 

provisioner "local-exec" {
   command = "PSExec.exe \\\\172.18.96.189 -h -u ${var.Conuser} -p ${var.Conpassword} Powershell C:\\Terraform\\script\\Get-IaCFiles_GENIISUAT.ps1 -UserName ${var.svnuser} -Password ${var.svnpassword}"
}
  
provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\connect.acme.local\\connect_acme_local_solo.rb"]
  }
}
