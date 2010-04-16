package "libdbi-perl"
package "zlib1g-dev"

version = node[:xtradb][:version]
uri = node[:xtradb][:uri]

remote_file "/usr/src/percona-xtradb-common_#{version}_all.deb" do
  source "#{uri}/percona-xtradb-common_#{version}_all.deb"
  checksum "96e02431"
  owner "root"
  group "root"
  mode "644"
end

remote_file "/usr/src/libpercona-xtradb-client16_#{version}_amd64.deb" do
  source "#{uri}/libpercona-xtradb-client16_#{version}_amd64.deb"
  checksum "07aa2f0b"
  owner "root"
  group "root"
  mode "644"
end

remote_file "/usr/src/percona-xtradb-client-5.1_#{version}_amd64.deb" do
  source "#{uri}/percona-xtradb-client-5.1_#{version}_amd64.deb"
  checksum "9d79fbe2"
  owner "root"
  group "root"
  mode "644"
end

remote_file "/usr/src/libpercona-xtradb-client-dev_#{version}_amd64.deb" do
  source "#{uri}/libpercona-xtradb-client-dev_#{version}_amd64.deb"
  checksum "f2597a19"
  owner "root"
  group "root"
  mode "644"
end

dpkg_package "percona-xtradb-common" do
  source "/usr/src/percona-xtradb-common_#{version}_all.deb"
end

dpkg_package "libpercona-xtradb-client16" do
  source "/usr/src/libpercona-xtradb-client16_#{version}_amd64.deb"
end

dpkg_package "percona-xtradb-client-5.1" do
  source "/usr/src/percona-xtradb-client-5.1_#{version}_amd64.deb"
  not_if "dpkg-query -l percona-xtradb-client-5.1"
end

dpkg_package "libpercona-xtradb-client-dev" do
  source "/usr/src/libpercona-xtradb-client-dev_#{version}_amd64.deb"
end
