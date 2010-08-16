include_recipe "git"

package "zsh"

execute "clone oh-my-zsh repository" do
  command "git clone git://github.com/robbyrussell/oh-my-zsh.git"
  cwd "/usr/src"
  not_if "test -d /usr/src/oh-my-zsh"
end

link "/home/#{node.zsh.user}/.oh-my-zsh" do
  to "/usr/src/oh-my-zsh"
end

template "/home/#{node.zsh.user}/.zshrc" do
  source "zshrc.zsh.erb"
  owner node.zsh.user
  group node.zsh.user
  mode "644"
end

execute "change shell" do
  command "chsh --shell /bin/zsh #{node.zsh.user}"
  not_if "grep #{node.zsh.user}.*zsh.* /etc/passwd"
end

