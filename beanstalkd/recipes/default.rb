package "beanstalkd" do
  action :upgrade
end

ree_gem "beanstalk-client"

template "/etc/default/beanstalkd"

service "beanstalkd" do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end
