siteName = 'connect.acme.local'
siteDirectory = "D:\\Websites\\#{siteName}" 


class WebsiteBindings
    @bindings = []
    def initialize(bindings)
        @bindings = bindings
    end
    def to_psobject()
        bindings = Array.new()
        @bindings.each do |b|
            bindings.push("(new-ciminstance -classname MSFT_xWebBindingInformation -Namespace root/microsoft/Windows/DesiredStateConfiguration -Property @{Protocol='#{b[:protocol]}';IPAddress='#{b[:ip]}';Port=#{b[:port]}} -ClientOnly)")
        end
        "[ciminstance[]](#{bindings.join(',')})"
    end
end

bindings = WebsiteBindings.new([
      { protocol: "HTTP", ip: '*', port: 18106 },
      { protocol: "HTTP", ip: '*', port: 8106 }
  ])

dsc_resource 'connect.acme.local AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-appraisal AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-appraisal"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-hub-v1 AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-hub-v1"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-hub-v2 AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, "connect.acme.local-hub-v2"
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-start AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, 'connect.acme.local-hub-start'
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local-wrm AppPool' do
	module_name :xWebAdministration
	resource 	:xWebAppPool
	property    :Name, 'connect.acme.local-hub-wrm'
	property    :Ensure, 'Present'	
	property	:State, 'Started'
end

dsc_resource 'connect.acme.local WebSite' do
	module_name :xWebAdministration
	resource 	:xWebsite 
	property    :Name, siteName
	property    :BindingInfo, bindings	
	property    :PhysicalPath, siteDirectory	
	property	:State, 'Started'
	property    :ApplicationPool, siteName	
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-appraisal Application' do
	module_name :xWebAdministration
	resource 	:xWebApplication 
	property    :Website, siteName
	property	:Name, 'appraisal'
	property    :WebAppPool, 'connect.acme.local-appraisal'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\appraisal"
	property	:Ensure, 'Present'
end 

dsc_resource 'connect.acme.local-appraisal Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, 'appraisal'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\appraisal"	
	property	:Name, 'appraisal'
	property	:Ensure, 'Present'
end


dsc_resource 'connect.acme.local-hub-v1 Application' do
	module_name :xWebAdministration
	resource 	:xWebApplication 
	property    :Website, 'connect.acme.local/hub'
	property	:Name, 'v1'
	property    :WebAppPool, 'connect.acme.local-hub-v1'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\hub\\v1"
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-hub-v1 Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, 'v1'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\hub\\v1"	
	property	:Name, 'v1'
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-hub-v2 Application' do
	module_name :xWebAdministration
	resource 	:xWebApplication 
	property    :Website,  'connect.acme.local/hub'
	property	:Name, 'v2'
	property    :WebAppPool, 'connect.acme.local-hub-v2'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\hub\\v2"
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-hub-v2 Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, 'v2'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\hub\\v2"	
	property	:Name, 'v2'
	property	:Ensure, 'Present'
end


dsc_resource 'connect.acme.local-start Application' do
	module_name :xWebAdministration
	resource 	:xWebApplication 
	property    :Website, siteName
	property	:Name, 'start'
	property    :WebAppPool, 'connect.acme.local-start'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\start"
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-start Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, 'start'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\start"	
	property	:Name, 'start'
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-wrm Application' do
	module_name :xWebAdministration
	resource 	:xWebApplication 
property    :Website, siteName
	property	:Name, 'wrm'
	property    :WebAppPool, 'connect.acme.local-wrm'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\wrm"
	property	:Ensure, 'Present'
end

dsc_resource 'connect.acme.local-wrm Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, 'wrm'	
	property    :PhysicalPath, "D:\\Websites\\connect.acme.local\\wrm"	
	property	:Name, 'wrm'
	property	:Ensure, 'Present'
end

dsc_resource 'lbcheck Virtual Directory' do
	module_name :xWebAdministration
	resource 	:xWebVirtualDirectory
	property    :Website, siteName
	property    :WebApplication, ''	
	property    :PhysicalPath, "D:\\Keepalives\\connect.acme.local"	
	property	:Name, 'lbcheck'
	property	:Ensure, 'Present'
end