windows_zipfile 'Unpack connect.acme.local' do
    source "D:\\Terraform\\archive\\connect.acme.local.zip"
	path "D:\\Websites"
	overwrite
	action :unzip
	not_if {::File.exists?('D:\\Websites\\connect.acme.local')}
 end

dsc_resource 'connect.acme.local' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-appraisal' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-appraisal"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-hub-v1' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-hub-v1"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-hub-v2' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-hub-v2"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-start' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, 'connect.acme.local-hub-start'
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-wrm' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, 'connect.acme.local-hub-wrm'
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end