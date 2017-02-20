resource "null_resource" "GENAPPUAT_WEB_CONFIG" {
  depends_on = ["null_resource.GENAPP_CONFIG"]

  connection {
    type     = "winrm"
    user     = "${var.Conuser}"
    password = "${var.Conpassword}"
    host     = "172.18.96.190"
    insecure = "false"
    timeout  = "90m"
  }

  provisioner "file" {
    source      = "scripts\\remote_exec_GENAPP"
    destination = "C:\\Terraform\\script"
  }

 
  provisioner "local-exec" {
    command = "PSExec.exe \\\\172.18.96.190 -h -u ${var.Conuser} -p ${var.Conpassword} Powershell C:\\Terraform\\script\\Get-IaCFiles_GENAPPUAT.ps1 -UserName ${var.svnuser} -Password ${var.svnpassword}"
  }

  provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\genappuat\\genappuat_solo.rb"]
  }

  }
