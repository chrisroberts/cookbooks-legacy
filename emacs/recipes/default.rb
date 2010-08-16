include_recipe "git"

package "emacs23-nox"

execute "clone emacs starter kit" do
  command "git clone git://github.com/technomancy/emacs-starter-kit.git"
  cwd "/usr/src"
  not_if "test -d /usr/src/emacs-starter-kit"
end

execute "copy starter kit" do
  command "cp -r /usr/src/emacs-starter-kit /home/#{node.emacs.user}/.emacs.d"
  user node.emacs.user
  group node.emacs.user
  not_if "test -d /home/#{node.emacs.user}/.emacs.d"
end
