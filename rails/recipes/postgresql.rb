include_recipe "postgresql::client"
ree_gem "pg"

template "/var/www/shared/database.yml" do
  source "database.yml.erb"
  owner "www-data"
  group "www-data"
  mode "644"
  variables( 
    :username => node[:postgresql][:username],
    :password => node[:postgresql][:password],
    :db_name => node[:postgresql][:db_name] )
end
