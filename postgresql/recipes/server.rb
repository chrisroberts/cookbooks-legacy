package "postgresql"

service "postgresql-8.4" do
  supports :restart => true, :status => true, :reload => true
  action :enable
end

template "/etc/postgresql/8.4/main/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode "640"
  notifies :restart, resources(:service => "postgresql-8.4")
end
