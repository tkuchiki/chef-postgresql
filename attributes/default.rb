if node[:platform] == "centos"
  default[:postgresql] = {
    :client_package => "postgresql92-postgresql",
    :dev_package    => "postgresql92-postgresql-devel",
    :server_package => "postgresql92-postgresql-server",
    :service_name   => "postgresql92-postgresql",
    :pgdir          => "/opt/rh/postgresql92/root/var/lib/pgsql",
  }
elsif node[:platform] == "amazon"
  default[:postgresql] = {
    :client_package => "postgresql9",
    :dev_package    => "postgresql9-devel",
    :server_package => "postgresql9-server",
    :service_name   => "postgresql",
    :pgdir          => "/var/lib/pgsql9",
  }
end

default[:postgresql][:pgdata] = node[:postgresql][:pgdir] + "/data"

default[:postgresql][:packages] = []
