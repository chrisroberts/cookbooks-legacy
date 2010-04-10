gem_package "rack" do
  version "1.0.1"
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :install
end

execute "remove newer rack versions" do
  command "gem uninstall rack --version '> 1.0.1'"
  only_if "gem list rack --installed --version '> 1.0.1'"
end

gem_package "rails" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end