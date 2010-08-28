execute "synchronize package index" do
  command "apt-get update"
  action :nothing
end

execute "set java alternatives" do
  command "update-java-alternatives -s java-6-sun"
  returns 2
  action :nothing
end

template "/etc/apt/sources.list.d/lucid_partners" do
  notifies :run, resources(:execute => "synchronize package index"), :immediately
end

package "sun-java6-jdk" do
  response_file "java.seed"
  notifies :run, resources(:execute => "set java alternatives"), :immediately
end
