dsc_resource 'Set_Time_Zone' do
	module_name :xTimeZone
	resource    :xTimeZone
	property	:isSingleInstance, 'yes'
	property    :TimeZone, 'Eastern Standard Time'
end

dsc_resource 'Disk_Drive' do
	module_name :xStorage
	resource    :xWaitforDisk
	property    :DiskNumber, 1
	property    :RetryIntervalSec, 60	
	property    :RetryCount, 60
end

dsc_resource 'Data_Volume' do
	module_name :xStorage
	resource 	:xDisk
	property    :DiskNumber, 1
	property    :DriveLetter, 'D'	
	property	:FSLabel, 'Data'
end

dsc_resource 'Create Dir Webiste' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\Websites"
	property    :Ensure, 'Present'		
end

dsc_resource 'Create Dir KmxData' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\KmxData"
	property    :Ensure, 'Present'		
end

dsc_resource 'Create Dir Logs' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\Logs"
	property    :Ensure, 'Present'		
end

dsc_resource 'Create Dir Scripts' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\Scripts"
	property    :Ensure, 'Present'		
end

dsc_resource 'Create Dir Staging' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\Staging"
	property    :Ensure, 'Present'		
end

dsc_resource 'Create Dir Temp' do
	resource 	:File
	property	:Type, 'Directory'	
    property 	:DestinationPath, "D:\\Temp"
	property    :Ensure, 'Present'		
end

windows_package 'Install Rewrite 2.0' do
  action :install
  source 'C:\Terraform\software\rewrite_2.0_rtw_x64.msi'
  options '/quiet'
end

windows_package 'Install Asp Net MVC 3' do
  action :install
  source 'C:\Terraform\software\AspNetMVC3Setup.exe'
  installer_type :custom
  options '/quiet'
end

windows_package 'Install Asp Net MVC 4' do
  action :install
  source 'C:\Terraform\software\AspNetMVC4Setup.exe'
  installer_type :custom
  options '/quiet'
end



