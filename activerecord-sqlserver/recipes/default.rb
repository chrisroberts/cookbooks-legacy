include_recipe "www-data"
include_recipe "ruby-odbc"

gem_package "activerecord-sqlserver-adapter"

template "/var/www/shared/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "www-data"
  mode "644"
  variables( 
    :dsn => node[:sqlserver][:dsn],
    :username => node[:sqlserver][:username],
    :password => node[:sqlserver][:password],
    :db_name => node[:sqlserver][:db_name] )
end

template "/etc/odbc.ini" do
  source "odbc.ini.erb"
  owner "root"
  group "root"
  mode "644"
  variables( 
    :db_name => node[:sqlserver][:db_name] )
end

template "/etc/freetds.conf" do
  source "freetds.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables( 
    :host => node[:sqlserver][:host],
    :port => node[:sqlserver][:port],
    :tds_version => node[:freetds][:tds_version] )
end
