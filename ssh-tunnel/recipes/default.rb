%w( ssh autossh postfix mailx ).each do |p|
  package p
end

user "tunnel" do
  home "/home/tunnel"
end

%w( /home/tunnel /home/tunnel/.ssh ).each do |d|
  directory d do
    owner "tunnel"
    group "tunnel"
    mode "755"
  end
end

template "/home/tunnel/.ssh/config" do
  source "ssh-config.erb"
  owner "tunnel"
  group "tunnel"
  mode "644"
  variables( 
    :alive_interval => node[:tunnel][:alive_interval],
    :alive_count => node[:tunnel][:alive_count] )
end

execute "ssh-keygen" do
  command "ssh-keygen -q -t rsa -f .ssh/id_rsa -N \"\""
  cwd "/home/tunnel"
  user "tunnel"
  group "tunnel"
  creates "/home/tunnel/.ssh/id_rsa"
end

execute "email public key" do
  command "mail #{node[:tunnel][:address]} < .ssh/id_rsa.pub && touch key_sent"
  cwd "/home/tunnel"
  user "tunnel"
  group "tunnel"
  creates "/home/tunnel/key_sent"
end

template "/etc/rc.local" do
  source "rc.local.erb"
  owner "root"
  group "root"
  mode "755"
  variables( :proxy => node[:tunnel][:proxy] )
end
