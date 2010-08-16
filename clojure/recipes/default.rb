include_recipe "java"
include_recipe "git"
include_recipe "emacs"
include_recipe "zsh"

package "unzip"
package "ant"
package "maven2"

execute "clone clojure repository" do
  command "git clone git://github.com/clojure/clojure.git"
  cwd "/usr/src"
  not_if "test -d /usr/src/clojure"
end

execute "build clojure" do
  command "ant"
  cwd "/usr/src/clojure"
  not_if "test -f /usr/src/clojure/clojure.jar"
end

execute "clone clojure-contrib repository" do
  command "git clone git://github.com/clojure/clojure-contrib.git"
  cwd "/usr/src"
  not_if "test -d /usr/src/clojure-contrib"
end

execute "build clojure-contrib" do
  command "mvn package"
  cwd "/usr/src/clojure-contrib"
  not_if "test -f /usr/src/clojure-contrib/target/clojure-contrib-*-SNAPSHOT.jar"
end

remote_file "/usr/src/jline-0.9.94.zip" do
  source "http://downloads.sourceforge.net/project/jline/jline/0.9.94/jline-0.9.94.zip"
  checksum "61488e90"
end

execute "unzip jline archive" do
  command "unzip jline-0.9.94.zip"
  cwd "/usr/src"
  not_if "test -d /usr/src/jline-0.9.94"
end

remote_file "/usr/local/bin/lein" do
  source "http://github.com/technomancy/leiningen/raw/stable/bin/lein"
  checksum "e1d425a6"
  mode "755"
end

clojure_path = "/home/#{node.clojure.user}/.clojure"

directory "#{clojure_path}/bash" do
  owner node.clojure.user
  group node.clojure.user
  recursive true
  action :create
end

link "#{clojure_path}/clojure.jar" do
  to "/usr/src/clojure/clojure.jar"
end

link "#{clojure_path}/clojure-contrib.jar" do
  to "/usr/src/clojure-contrib/target/clojure-contrib-*-SNAPSHOT.jar"
end

link "#{clojure_path}/jline-0.9.94.jar" do
  to "/usr/src/jline-0.9.94/jline-0.9.94.jar"
end

template "#{clojure_path}/bash/clj-env-dir" do
  owner node.clojure.user
  group node.clojure.user
  mode "755"
end

template "/home/#{node.clojure.user}/.zshrc" do
  source "zshrc.zsh.erb"
  owner node.clojure.user
  group node.clojure.user
  mode "644"
end

execute "install lein" do
  command "/usr/local/bin/lein self-install"
  user node.clojure.user
  group node.clojure.user
  not_if "test -d /home/#{node.clojure.user}/.m2/repository/leiningen"
end

# emacs package-install slime clojure-mode
