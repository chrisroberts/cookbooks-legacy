gem_package "rack" do
  version "1.0.1"
  action :install
end

execute "remove newer rack versions" do
  command "gem uninstall rack --version '> 1.0.1'"
  only_if "gem list rack --installed --version '> 1.0.1'"
end

gem_package "rails" do
  version "2.3.5"
  action :install
end
