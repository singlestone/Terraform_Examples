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

$UrlChefGenAPP = "https://subversion.acme.org:8080/svn/kmx/Architecture/IaC/Terraform/PoC/scripts/chef/cookbooks_GENAPPUAT"
$GenAPPLocalPath = "C:\chef\\cookbooks\" 


$UrlDD = "https://subversion.acme.org:8080/svn/kmx/Architecture/IaC/Terraform/PoC/artifacts/Data_Drive_GENAPPUAT"
$UrlDDModLocalPath = "D:\"

Get-Files -Url $UrlChefGenIIS -LocalPath $GenAPPLocalPath
Get-Files -Url $UrlDD   -LocalPath $UrlDDModLocalPath

