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
  variables :hostname => node.nginx.hostname
  notifies :restart, resources( :service => "nginx" )
end
