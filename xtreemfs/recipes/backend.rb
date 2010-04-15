include_recipe "java"

uri = node[:xtreemfs][:repository_uri]
version = node[:xtreemfs][:version]

remote_file "/usr/src/xtreemfs-backend_#{version}_all.deb" do
  source "#{uri}/all/xtreemfs-backend_#{version}_all.deb"
  checksum node[:xtreemfs][:backend_checksum]
  mode "644"
  owner "root"
  group "root"
end

dpkg_package "xtreemfs-backend_#{version}_all.deb" do
  source "/usr/src/xtreemfs-backend_#{version}_all.deb"
end
