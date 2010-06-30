template "/etc/init.d/unicorn" do
  source "unicorn-init.sh.erb"
  owner "root"
  group "root"
  mode "755"
  variables :environment => node.unicorn.environment
end

ree_gem "unicorn" do
  action :install
end

service "unicorn" do
  supports :start => true, :stop => true, :restart => true, :reload => true
  action :enable
end

directory "/etc/unicorn" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/etc/unicorn/app.rb" do
  source "unicorn.rb.erb"
  owner "root"
  group "root"
  mode "644"
  variables( :cow_friendly => node[:unicorn][:cow_friendly])
  # notifies :restart, resources(:service => "unicorn")
end
