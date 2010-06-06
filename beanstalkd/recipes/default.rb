package "beanstalkd" do
  action :upgrade
end

gem_package "beanstalk-client"

template "/etc/default/beanstalkd"

service "beanstalkd" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end
