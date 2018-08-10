#
# Cookbook:: samples
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set a hostname on operating system level
hostname node['host_name']

# Install a package called “my-monitoring-agent”
# Assume that the package repository providing that package is already configured
package 'my-monitoring-agent'

# Set the hostname in the configuration of the monitoring agent
# Assume that the configuration file is located at “/etc/mon-agent/agent.conf”
# And it has a line in it like “hostname=xxx”
directory '/etc/mon-agent/'

template '/etc/mon-agent/agent.conf' do
source  'agent.conf.erb'
end

node[users].each do |x|
	user "#{x}" do
	  manage_home true
	  gid 'my-staff'
	  home "/home/#{x}"
	end
end

# Ensure that the two users, “alice” and “bob”, exist and are part of the group “my-staff”
# ruby_block 'Add users' do
  # block do
    # %w[alice bob] { |x|
	# }
	# done
  # end
  # action :run
# end

