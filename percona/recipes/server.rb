include_recipe "percona::default"

package "percona-server-server"

service "mysql" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
