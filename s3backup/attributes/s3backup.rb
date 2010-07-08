default[:aws][:key_id] = "aws key id"
default[:aws][:secret] = "aws secret"
default[:s3backup][:keep_days] = 8
default[:s3backup][:minute] = 0
default[:s3backup][:hour] = 22
default[:s3backup][:postgres_bucket] = "bucket-name"
default[:s3backup][:dump_directory] = "/var/backups/postgresql"
