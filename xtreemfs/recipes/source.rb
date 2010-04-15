include_recipe "java"

%w( libssl-dev libfuse-dev ant ).each do |p|
  package p
end

version = "1.2.1"

remote_file "/usr/src/XtreemFS-#{version}.tar.gz" do
  source "http://xtreemfs.googlecode.com/files/XtreemFS-#{version}.tar.gz"
  checksum "018fb99c"
  owner "root"
  group "root"
  mode "644"
end

execute "untar xtreemfs" do
  command "tar xzf XtreemFS-#{version}.tar.gz"
  creates "/usr/src/XtreemFS-#{version}/README.XOS"
  user "root"
  cwd "/usr/src"
end