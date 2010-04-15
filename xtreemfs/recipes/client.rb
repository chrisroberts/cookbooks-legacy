include_recipe "xtreemfs::backend"
package "attr"

uri = node[:xtreemfs][:repository_uri]
version = node[:xtreemfs][:version]

remote_file "/usr/src/xtreemfs-client_#{version}_amd64.deb" do
  source "#{uri}/amd64/xtreemfs-client_#{version}_amd64.deb"
  checksum node[:xtreemfs][:x86_64_client_checksum]
  mode "644"
  owner "root"
  group "root"
  only_if do node[:kernel][:machine] == "x86_64" end
end

remote_file "/usr/src/xtreemfs-client_#{version}_i386.deb" do
  source "#{uri}/i386/xtreemfs-client_#{version}_i386.deb"
  checksum node[:xtreemfs][:i386_client_checksum]
  mode "644"
  owner "root"
  group "root"
  only_if do node[:kernel][:machine] == "i386" end
end

remote_file "/usr/src/xtreemfs-tools_#{version}_all.deb" do
  source "#{uri}/all/xtreemfs-tools_#{version}_all.deb"
  checksum node[:xtreemfs][:tools_client_checksum]
  mode "644"
  owner "root"
  group "root"
end

dpkg_package "xtreemfs-tools_#{version}_all.deb" do
  source "/usr/src/xtreemfs-tools_#{version}_all.deb"
end

dpkg_package "xtreemfs-client_#{version}_amd64.deb" do
  source "/usr/src/xtreemfs-client_#{version}_amd64.deb"
  only_if do node[:kernel][:machine] == "x86_64" end
end

dpkg_package "xtreemfs-client_#{version}_i386.deb" do
  source "/usr/src/xtreemfs-client_#{version}_i386.deb"
  only_if do node[:kernel][:machine] == "i386" end
end
