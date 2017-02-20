provider "vsphere" {
  user                 = "${var.VMuser}"
  password             = "${var.VMpassword}"
  vsphere_server       = "ENTVCST02.kmxtest.local"
  allow_unverified_ssl = "true"
}

# Create a folder
resource "vsphere_folder" "VMFolder" {
  datacenter = "${var.datacenter}"
  path = "${var.VMFolder}"

}

module "GENIISUAT" {
  source = "./scripts/TF_modules/GENIISUAT"
  svnuser = "${var.svnuser}"
  svnpassword = "${var.svnpassword}"
  Conuser = "${var.Conuser}"
  Conpassword = "${var.Conpassword}" 
}

module "GENAPPUAT" {
  source      = "./scripts/TF_modules/GENAPPUAT"
  svnuser = "${var.svnuser}"
  svnpassword = "${var.svnpassword}"
  Conuser = "${var.Conuser}"
  Conpassword = "${var.Conpassword}"
}
<<<<<<< .mine

module "GENAPPUAT" {
  source      = "./scripts/TF_modules/GENAPPUAT"
  svnuser = "${var.svnuser}"
  svnpassword = "${var.svnpassword}"
  Conuser = "${var.Conuser}"
  Conpassword = "${var.Conpassword}"
}
||||||| .r227041

#module "GENAPPUAT" {
#  source      = "./scripts/TF_modules/GENAPPUAT"
#  svnuser = "${var.svnuser}"
#  svnpassword = "${var.svnpassword}"
#  Conuser = "${var.Conuser}"
#  Conpassword = "${var.Conpassword}"
#}
=======
>>>>>>> .r228357
