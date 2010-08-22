package "dnsmasq"

service "dnsmasq" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

template "/etc/dnsmasq.conf" do
  notifies :restart, resources( :service => "dnsmasq" )
end

