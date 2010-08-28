include_recipe "git"
include_recipe "zsh"

package "curl"

directory "/home/#{node.rvm.user}/.rvm/src" do
  owner node.rvm.user
  group node.rvm.user
  recursive true
  mode "755"
  action :create
end

execute "clone rvm" do
  command "git clone --depth 1 git://github.com/wayneeseguin/rvm.git"
  creates "/home/#{node.rvm.user}/.rvm/src/rvm"
  user node.rvm.user
  group node.rvm.user
  cwd "/home/#{node.rvm.user}/.rvm/src"
end

execute "install rvm" do
  command "./install"
  user node.rvm.user
  group node.rvm.user
  creates "/home/#{node.rvm.user}/.rvm/bin"
  cwd "/home/#{node.rvm.user}/.rvm/src/rvm"
end

=begin

# to update .zshrc from different places it should filter
# through the zsh cookbook

execute "append rvm shell" do
  command "echo \"[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && \. \"$HOME/.rvm/scripts/rvm\"\" >> ~#{node.rvm.user}/.zshrc"
  not_if "grep rvm ~#{node.rvm.user}/.zshrc"
end

=end

template "/home/#{node.rvm.user}/.rvmrc" do
  source "rvmrc.erb"
  owner node.rvm.user
  group node.rvm.user
  mode "644"
end
