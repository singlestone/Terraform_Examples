
Start-Process -FilePath 'C:\Terraform\software\7z1602-x64.msi' `
    -ArgumentList '/quiet' `
    -wait


Start-Process -FilePath 'C:\Program Files\7-Zip\7z.exe' `
    -ArgumentList 'x C:\Terraform\modules.zip -aoa -oC:\Terraform' `
    -wait

	
(gwmi Win32_cdromdrive).drive | %{$a = mountvol $_ /l;mountvol $_ /d;$a = $a.Trim();mountvol e: $a}