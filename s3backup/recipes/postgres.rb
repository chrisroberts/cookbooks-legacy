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
             :bucket => node.s3backup.postgres_bucket,
             :keep_days => node.s3backup.keep_days,
             :dump_directory => node.s3backup.dump_directory )
end

directory "postgresql backup" do
  path node.s3backup.dump_directory
  owner "postgres"
  group "postgres"
end

cron "postgres backup cron job" do
  minute node.s3backup.minute
  hour node.s3backup.hour
  command "/usr/local/sbin/s3_postgres_backup.sh"
  user "postgres"
end
