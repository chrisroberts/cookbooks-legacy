gem_package node[:bundler][:legacy] ? "bundler08" : "bundler" do
  action :upgrade
end
