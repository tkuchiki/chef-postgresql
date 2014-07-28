include_recipe "chef-postgresql::centos" if node[:platform] == "centos"

package node[:postgresql][:client_package]

node[:postgresql][:packages].each do |postgresql_package|
  package postgresql_package
end
