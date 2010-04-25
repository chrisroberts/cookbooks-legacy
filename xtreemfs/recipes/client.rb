include_recipe "xtreemfs::backend"

package "attr"
package "libfuse2"

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
  only_if do node[:kernel][:machine] == "i686" end
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
  only_if do node[:kernel][:machine] == "i686" end
end

execute "load fuse kernel module" do
  command "modprobe fuse"
  user "root"
  not_if "lsmod | grep fuse"
end

execute "include fuse kernel module at boot" do
  command "echo fuse >> /etc/modules"
  user "root"
  not_if "grep fuse /etc/modules"
end

