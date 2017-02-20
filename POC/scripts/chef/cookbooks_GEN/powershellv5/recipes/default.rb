
powershell_script 'Install Powershell v5' do
	code 'Start-Process `
		-FilePath C:\vagrant\software\Win8.1AndW2K12R2-KB3134758-x64.msu `
		-ArgumentList "/quiet /norestart" -wait'
	not_if '(($PSVersionTable.PSVersion).Major -ge (5))'
end

