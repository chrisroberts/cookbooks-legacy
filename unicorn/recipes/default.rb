# this code sucks

  if File.exists? "/usr/local/bin/ruby"
    gem_home = "/usr/local/lib/ruby/gems/1.8"
    gem_path = "/usr/local/bin"
  elsif File.exists? "/home/rvm/.rvm/bin/rvm"
    gem_home = `sudo -H -u rvm /home/rvm/.rvm/bin/rvm gemdir`.strip
    gem_path = gem_home + "/bin"
  else
    gem_home = "/var/lib/gems/1.8"
    gem_path = gem_home + "/bin"
  end

# end suck

template "/etc/init.d/unicorn" do
  source "unicorn-init.sh.erb"
  owner "root"
  group "root"
  mode "755"
  variables( 
    :gem_path => gem_path,
    :gem_home => gem_home )
end

gem_package "unicorn" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
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
  #notifies :restart, resources(:service => "unicorn")
end