remote_file "/usr/src/s3sync.tar.gz" do
  source "http://s3.amazonaws.com/ServEdge_pub/s3sync/s3sync.tar.gz"
  checksum "ee58d6f9"
  owner "root"
  group "root"
  mode "644"
end

execute "untar s3sync" do
  command "tar xzf s3sync.tar.gz"
  cwd "/usr/src"
  creates "/usr/src/s3sync/README.txt"
end

template "/usr/local/sbin/s3_postgres_backup.sh" do
  owner "root"
  group "root"
  mode "755"
  variables( :key_id => node.aws.key_id,
             :secret => node.aws.secret,
             :dump_directory => node.s3backup.dump_directory )
end

