db_name = node[:postgresql][:db_name]
username = node[:postgresql][:username]
password = node[:postgresql][:password]

execute "create #{username} database user" do
  command "createuser --createdb --no-createrole --no-superuser #{username} && \
    psql --command \"alter role #{username} with encrypted password '#{password}'\""
  user "postgres"
  not_if do
    `sudo -u postgres psql --tuples-only --command=" \
      select rolname from pg_roles where \
      rolname = '#{username}'"`.strip == "#{username}"
  end
end

execute "create #{db_name} database" do
  command "createdb --encoding=UTF8 --owner=#{username} #{db_name}"
  user "postgres"
  not_if do
    `sudo -u postgres psql --tuples-only --command=" \
      select datname from pg_database where \
      datname = '#{db_name}'"`.strip == "#{db_name}"
  end
end

execute "alter schema public owner to #{username}" do
  command "psql --dbname=#{db_name} --command='alter schema public owner to #{username}'"
  user "postgres"
  not_if "sudo -u postgres psql --dbname=#{db_name} --command='\\dn' | grep #{username}"
end

# mixing of concerns to support a downstream process.
include_recipe "www-data"
template "/var/www/.pgpass" do
  source "pgpass.erb"
  mode "600"
  owner "www-data"
  group "www-data"
  variables( :username => username, :password => password)
end
