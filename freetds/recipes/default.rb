include_recipe "unixodbc"

package "libssl-dev"

version = node[:freetds][:version]

remote_file "/usr/src/freetds-#{version}.tar.gz" do
  source "http://ftp.ibiblio.org/pub/linux/ALPHA/freetds/stable/freetds-#{version}.tar.gz"
  checksum node[:freetds][:checksum]
end

execute "untar FreeTDS" do
  command "tar xzf freetds-#{version}.tar.gz"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/freetds-#{version}/README"
end

execute "configure FreeTDS" do
  command "./configure --prefix=/usr --sysconfdir=/etc --with-tdsver=#{node[:freetds][:tds_version]}"
  cwd "/usr/src/freetds-#{version}"
  creates "/usr/src/freetds-#{version}/Makefile"
end

execute "build FreeTDS" do
  command "make"
  cwd "/usr/src/freetds-#{version}"
  creates "/usr/src/freetds-#{version}/src/apps/tsql"
end

execute "install FreeTDS" do
  command "make install"
  cwd "/usr/src/freetds-#{version}"
  user "root"
  group "root"
  creates "/usr/bin/tsql"
end

template "/etc/odbcinst.ini" do
  source "odbcinst.ini.erb"
  owner "root"
  group "root"
  mode "644"
end
