platform    = node[:platform]
service_cmd = "/sbin/service"

if platform == "centos"
  package "centos-release-SCL"

  client_package = "postgresql92-postgresql"
  dev_package    = "postgresql92-postgresql-devel"
  server_package = "postgresql92-postgresql-server"
  service_name   = "postgresql92-postgresql"
elsif platform == "amazon"
  client_package = "postgresql9"
  dev_package    = "postgresql9-devel"
  server_package = "postgresql9-server"
  service_name   = "postgresql"
end

if node[:postgresql][:roles].include?("client")
  package client_package
end

if node[:postgresql][:roles].include?("dev")
  package dev_package
end

if node[:postgresql][:roles].include?("server")
  package server_package

  bash "postgresql initdb" do
    code   "#{service_cmd} #{service_name} initdb"
    not_if "#{service_cmd} #{service_name} status"
  end

  service service_name do
    action [:enable, :start]
  end
end

node[:postgresql][:packages].each do |postgresql_package|
  package postgresql_package
end
