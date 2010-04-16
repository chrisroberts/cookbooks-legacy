include_recipe "xtradb::client"

version = node[:xtradb][:version]
uri = node[:xtradb][:uri]

remote_file "/usr/src/percona-xtradb-server-5.1_#{version}_amd64.deb" do
  source "#{uri}/percona-xtradb-server-5.1_#{version}_amd64.deb"
  checksum "e1aee6a9"
  owner "root"
  group "root"
  mode "644"
end

dpkg_package "percona-xtradb-server-5.1" do
  source "/usr/src/percona-xtradb-server-5.1_#{version}_amd64.deb"
  not_if "dpkg-query -l percona-xtradb-server-5.1"
end

service "mysql" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end
