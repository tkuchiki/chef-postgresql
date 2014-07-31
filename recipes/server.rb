include_recipe "chef-postgresql::centos" if node[:platform] == "centos"

service_cmd  = "/sbin/service"
service_name = node[:postgresql][:service_name]
pgdata       = node[:postgresql][:pgdata]

package node[:postgresql][:server_package]

bash "postgresql initdb" do
  code   "#{service_cmd} #{service_name} initdb"
  not_if { File.exists?(pgdata + "/PG_VERSION") && File.exists?(pgdata + "/base") }
end

service service_name do
  action [:enable, :start]
end
