include_recipe "freetds"

version = node[:rubyodbc][:version]

remote_file "/usr/src/ruby-odbc-#{version}.tar.gz" do
  source "http://www.ch-werner.de/rubyodbc/ruby-odbc-#{version}.tar.gz"
  checksum node[:rubyodbc][:checksum]
end

execute "untar ruby-odbc" do
  command "tar xzf ruby-odbc-#{version}.tar.gz"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/ruby-odbc-#{version}/README"
end

execute "configure ruby-odbc" do
  command "ruby -C ext extconf.rb --disable-dlopen"
  cwd "/usr/src/ruby-odbc-#{version}"
  creates "/usr/src/ruby-odbc-#{version}/ext/Makefile"
end

execute "build ruby-odbc" do
  command "make -C ext"
  cwd "/usr/src/ruby-odbc-#{version}"
  creates "/usr/src/ruby-odbc-#{version}/ext/odbc.o"
end

execute "install ruby-odbc" do
  command "make -C ext install"
  cwd "/usr/src/ruby-odbc-#{version}"
  user "root"
  group "root"
  if node[:kernel][:machine] == "x86_64"
    creates "/usr/local/lib/site_ruby/1.8/x86_64-linux/odbc.so"
  else
    creates "/usr/local/lib/site_ruby/1.8/i686-linux/odbc.so"
  end
end
