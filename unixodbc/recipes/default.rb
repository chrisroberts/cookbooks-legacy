version = node[:unixodbc][:version]

remote_file "/usr/src/unixODBC-#{version}.tar.gz" do
  source "http://www.unixodbc.org/unixODBC-#{version}.tar.gz"
  checksum node[:unixodbc][:checksum]
end

execute "untar unixODBC" do
  command "tar xzf unixODBC-#{version}.tar.gz"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/unixODBC-#{version}/README"
end

execute "configure unixODBC" do
  command "./configure --prefix=/usr --sysconfdir=/etc --enable-gui=no"
  cwd "/usr/src/unixODBC-#{version}"
  creates "/usr/src/unixODBC-#{version}/Makefile"
end

execute "build unixODBC" do
  command "make"
  cwd "/usr/src/unixODBC-#{version}"
  creates "/usr/src/unixODBC-#{version}/exe/isql"
end

execute "install unixODBC" do
  command "make install"
  cwd "/usr/src/unixODBC-#{version}"
  user "root"
  group "root"
  creates "/usr/lib/libodbc.so"
end
