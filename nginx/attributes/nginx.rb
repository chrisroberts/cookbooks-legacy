default[:nginx][:hostname] = `hostname -f`.strip
default[:nginx][:path] = "/usr/sbin"
default[:nginx][:version] = "0.7.65"
default[:nginx][:ssl] = "false"
default[:nginx][:log_format_name] = "default"
default[:nginx][:log_format] = %q('$remote_addr - $remote_user [$time_local]  '
                    '"$request" $status $body_bytes_sent '
                    '"$http_referer" "$http_user_agent"')
default[:nginx][:client_max_body_size] = "16M"
