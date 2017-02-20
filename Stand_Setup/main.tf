resource "null_resource" "Standard_Setup" {

  depends_on = ["vsphere_virtual_machine.GEN"]

  connection {
    type     = "winrm"
    user     = "${var.Conuser}"
    password = "${var.Conpassword}"
    host     = "192.168.1.140"
    insecure = "false"
    timeout  = "15m"
  }
  
  provisioner "file" {
    source      = "IaC_Scripts\\chef\\cookbooks_GEN\\"
    destination = "C:\\chef\\cookbooks"
  }

  provisioner "file" {
    source      = "IaC_Scripts\\ps_modules_GEN\\modules.zip"
    destination = "C:\\Terraform\\modules.zip"
  }

  provisioner "file" {
    source      = "IaC_Artifacts\\software_GEN"
    destination = "C:\\Terraform\\software"
  }

  provisioner "file" {
    source      = "IaC_Scripts\\remote_exec_GEN"
    destination = "C:\\Terraform\\script"
  }

  provisioner "remote-exec" {
    inline = ["powershell.exe -File C:\\Terraform\\script\\init_Setup.ps1"]
  }

  provisioner "remote-exec" {
    inline = ["chef-solo -c C:\\chef\\cookbooks\\solo\\solo.rb"]
  }

  provisioner "remote-exec" {
    inline = ["shutdown -r -t 0"]
	}
}
