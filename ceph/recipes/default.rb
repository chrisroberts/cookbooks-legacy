include_recipe "git"

%w( automake autoconf libtool 
    libfuse-dev btrfs-tools libboost-dev
    libedit-dev libssl-dev ).each do |p|
  package p
end

user "ceph" do
  home "/home/ceph"
  shell "/bin/bash"
end

%w( /home/ceph /home/ceph/.ssh 
    /var/log/ceph /var/run/ceph ).each do |d|
  directory d do
    owner "ceph"
    group "ceph"
    mode "755"
  end
end

remote_file "/home/ceph/.ssh/id_rsa" do
  source "id_rsa"
  owner "ceph"
  group "ceph"
  mode "600"
end

remote_file "/home/ceph/.ssh/id_rsa.pub" do
  source "id_rsa.pub"
  owner "ceph"
  group "ceph"
  mode "644"
end

remote_file "/home/ceph/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "ceph"
  group "ceph"
  mode "644"
end

execute "clone ceph server" do
  command "git clone git://ceph.newdream.net/git/ceph.git"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/ceph/README"
end

execute "clone ceph kernel module" do
  command "git clone git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client-standalone.git"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/ceph-client-standalone/README"
end

execute "generate ceph server configure script" do
  command "./autogen.sh"
  cwd "/usr/src/ceph"
  user "root"
  group "root"
  creates "/usr/src/ceph/configure"
end

execute "configure ceph server" do
  command "./configure --prefix=/usr --sysconfdir=/etc"
  cwd "/usr/src/ceph"
  user "root"
  group "root"
  creates "/usr/src/ceph/config.log"
end

execute "make ceph server" do
  command "make"
  cwd "/usr/src/ceph"
  user "root"
  group "root"
  creates "/usr/src/ceph/src/mount.ceph.o"
end

execute "install ceph server" do
  command "make install"
  cwd "/usr/src/ceph"
  user "root"
  group "root"
  creates "/usr/sbin/mkcephfs"
end

execute "make ceph kernel module" do
  command "make"
  cwd "/usr/src/ceph-client-standalone"
  user "root"
  group "root"
  creates "/usr/src/ceph-client-standalone/ceph.ko"
end

execute "install ceph kernel module" do
  command "make modules_install"
  cwd "/usr/src/ceph-client-standalone"
  user "root"
  group "root"
  not_if "test -f /lib/modules/`uname -r`/extra/ceph.ko"
end

execute "generate modules.dep for ceph kernel module" do
  command "depmod"
  user "root"
  group "root"
  not_if "grep ceph /lib/modules/`uname -r`/modules.dep"
end

execute "load ceph kernel module" do
  command "modprobe ceph"
  user "root"
  group "root"
  not_if "lsmod | grep ceph"
end

execute "include ceph kernel module at boot" do
  command "echo ceph >> /etc/modules"
  user "root"
  not_if "grep ceph /etc/modules"
end

template "/etc/ceph/ceph.conf" do
  source "ceph.conf.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/init.d/ceph" do
  source "init-ceph.sh.erb"
  owner "root"
  group "root"
  mode "755"
end
