package "postfix" do
  action :upgrade
end

package "bsd-mailx" do
  action :upgrade
end

service "postfix" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end
