
windows_feature_manage_feature 'install_Basic_Auth_Feature' do
	feature_name 'DSC-Service'
	action :install
end

%w{ 
	File-Services
	FS-FileServer
	Web-Server
	Web-WebServer
	Web-Common-Http
	Web-Static-Content
	Web-Default-Doc
	Web-Dir-Browsing
	Web-Http-Errors
	Web-Http-Redirect
	Web-App-Dev
	Web-Asp-Net45
	Web-Net-Ext45
	Web-ISAPI-Ext
	Web-ISAPI-Filter
	Web-Health
	Web-Http-Logging
	Web-Log-Libraries
	Web-Request-Monitor
	Web-Security
	Web-Basic-Auth
	Web-Windows-Auth
	Web-Digest-Auth
	Web-Client-Auth
	Web-Cert-Auth
	Web-Url-Auth
	Web-Filtering
	Web-IP-Security
	Web-Performance
	Web-Stat-Compression
	Web-Dyn-Compression
	Web-Mgmt-Tools
	Web-Mgmt-Console
	Web-Scripting-Tools
	Web-Mgmt-Service
	Web-Mgmt-Compat
	Web-Metabase
	Web-WMI
	Web-Lgcy-Scripting
	Web-Lgcy-Mgmt-Console
	Telnet-Client
	PowerShell-ISE
	}.each do |feature|
	windows_feature_manage_feature "Install Feature" do
		feature_name feature
		action :install
	end
end