#
# Cookbook:: cloud_init
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set a hostname on operating system level
hostname node['host_name']

# Install a package called “my-monitoring-agent”
# Assume that the package repository providing that package is already configured
rpm_package 'my-monitoring-agent' do
  source '/root/rpmbuild/RPMS/noarch/my-monitoring-agent-1.0-1.noarch.rpm'
  only_if { File::exists?('/root/rpmbuild/RPMS/noarch/my-monitoring-agent-1.0-1.noarch.rpm') }
end

# Set the hostname in the configuration of the monitoring agent
# Assume that the configuration file is located at “/etc/mon-agent/agent.conf”
# And it has a line in it like “hostname=xxx”
directory '/etc/mon-agent/'

template '/etc/mon-agent/agent.conf' do
source  'agent.conf.erb'
end

group 'my-staff'

# Ensure that the two users, “alice” and “bob”, exist and are part of the group “my-staff”
node['users'].each do |x|
	user "#{x}" do
	  manage_home true
	  gid 'my-staff'
	  home "/home/#{x}"
	end
end
