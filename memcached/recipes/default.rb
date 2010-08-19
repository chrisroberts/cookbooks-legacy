package "memcached" do
  action :upgrade
end

service "memcached" do
  supports :status => true, :restart => true
  action :enable
end

cookbook_file "/etc/default/memcached"

template "/etc/memcached.conf" do
  source "memcached.conf.erb"
  mode "644"
  owner "root"
  group "root"
  variables( :memory_mb => node[:memcached][:memory_mb].to_i)
  notifies :restart, resources(:service => "memcached")
end
