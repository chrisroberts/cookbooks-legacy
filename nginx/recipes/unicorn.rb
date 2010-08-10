include_recipe "nginx"

if node[:nginx][:ssl] == "true"
  conf = "unicorn-app-ssl.erb"
else
  conf = "unicorn-app.erb"
end

template "/etc/nginx/sites-available/app" do
  source conf
  owner "root"
  group "root"
  mode "644"
  variables(
            :hostname => node.nginx.hostname,
            :client_max_body_size => node.nginx.client_max_body_size )
  notifies :restart, resources( :service => "nginx" )
end
