include_recipe "xtreemfs::client"

uri = node[:xtreemfs][:repository_uri]
version = node[:xtreemfs][:version]

remote_file "/usr/src/xtreemfs-server_#{version}_all.deb" do
  source "#{uri}/all/xtreemfs-server_#{version}_all.deb"
  checksum node[:xtreemfs][:server_checksum]
  mode "644"
  owner "root"
  group "root"
end

dpkg_package "xtreemfs-server_#{version}_all.deb" do
  source "/usr/src/xtreemfs-server_#{version}_all.deb"
end

service "xtreemfs-dir" do
  pattern "xtreemfs.dir"
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "xtreemfs-mrc" do
  pattern "xtreemfs.mrc"
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "xtreemfs-osd" do
  pattern "xtreemfs.osd"
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end
