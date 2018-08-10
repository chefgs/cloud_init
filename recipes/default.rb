#
# Cookbook:: samples
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Set a hostname on operating system level
hostname '' do

# Install a package called “my-monitoring-agent”
# Assume that the package repository providing that package is already configured
package '' do

# Set the hostname in the configuration of the monitoring agent
# Assume that the configuration file is located at “/etc/mon-agent/agent.conf”
# And it has a line in it like “hostname=xxx”
template '/etc/mon-agent/agent.conf' do
end

# Ensure that the two users, “alice” and “bob”, exist and are part of the group “my-staff”
