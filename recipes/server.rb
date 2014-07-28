include_recipe "chef-postgresql::centos" if node[:platform] == "centos"

service_cmd  = "/sbin/service"
service_name = node[:postgresql][:service_name]

package node[:postgresql][:server_package]

bash "postgresql initdb" do
  code   "#{service_cmd} #{service_name} initdb"
  not_if "#{service_cmd} #{service_name} status"
end

service service_name do
  action [:enable, :start]
end
