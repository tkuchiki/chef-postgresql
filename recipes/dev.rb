include_recipe "chef-postgresql::centos" if node[:platform] == "centos"

package node[:postgresql][:dev_package]
