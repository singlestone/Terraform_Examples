	Param(
		[Parameter(Mandatory=$true)]$UserName,
		[Parameter(Mandatory=$true)]$Password
	)

Function Get-Files {
	Param(
		[Parameter(Mandatory=$true)]$Url,
		[Parameter(Mandatory=$true)]$LocalPath
	)

    svn export `
        $Url `
        $LocalPath `
		--force `
        --non-interactive `
        --no-auth-cache `
        --username $UserName `
        --password $Password `
        --trust-server-cert-failures=unknown-ca
}

$UrlChefGen = "https://subversion.acme.org:8080/svn/kmx/Architecture/IaC/Terraform/PoC/scripts/chef/cookbooks_GEN"
$ChefGenLocalPath = "C:\chef\\cookbooks\" 


$UrlPSMOD = "https://subversion.acme.org:8080/svn/kmx/Architecture/IaC/Terraform/PoC/scripts/ps_modules_GEN"
$PsModLocalPath = "C:\Program Files\WindowsPowerShell\Modules"


$UrlSoft = "https://subversion.acme.org:8080/svn/kmx/Architecture/IaC/Terraform/PoC/artifacts/software_GEN"
$SoftPsModLocalPath = "C:\Terraform\software\"

Get-Files -Url $UrlChefGen -LocalPath $ChefGenLocalPath
Get-Files -Url $UrlPSMOD   -LocalPath $PsModLocalPath
Get-Files -Url $UrlSoft    -LocalPath $SoftPsModLocalPath



(gwmi Win32_cdromdrive).drive | %{$a = mountvol $_ /l;mountvol $_ /d;$a = $a.Trim();mountvol e: $a}