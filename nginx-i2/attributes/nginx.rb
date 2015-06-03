###
# Do not use this file to override the nginx cookbook's default
# attributes.  Instead, please use the customize.rb attributes file,
# which will keep your adjustments separate from the AWS OpsWorks
# codebase and make it easier to upgrade.
#
# However, you should not edit customize.rb directly. Instead, create
# "nginx/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
#
# Do NOT create an 'nginx/attributes/nginx.rb' in your cookbooks. Doing so
# would completely override this file and might cause upgrade issues.
#
# See also: http://docs.aws.amazon.com/opsworks/latest/userguide/customizing.html
###

case node[:platform_family]
when "debian"
  default[:nginx-i2][:dir]        = "/etc/nginx"
  default[:nginx-i2][:log_dir]    = "/var/log/nginx"
  default[:nginx-i2][:user]       = "www-data"
  default[:nginx-i2][:binary]     = "/usr/sbin/nginx"
  if node[:platform_version] == "14.04"
    default[:nginx-i2][:pid_file] = "/run/nginx.pid"
  else
    default[:nginx-i2][:pid_file] = "/var/run/nginx.pid"
  end
when "rhel"
  default[:nginx-i2][:dir]        = "/etc/nginx"
  default[:nginx-i2][:log_dir]    = "/var/log/nginx"
  default[:nginx-i2][:user]       = "nginx"
  default[:nginx-i2][:binary]     = "/usr/sbin/nginx"
  default[:nginx-i2][:pid_file]   = "/var/run/nginx.pid"
else
  Chef::Log.error "Cannot configure nginx, platform unknown"
end

default[:nginx-i2][:log_format] = {}

# increase if you accept large uploads
default[:nginx-i2][:client_max_body_size] = "4m"

default[:nginx-i2][:gzip] = "on"
default[:nginx-i2][:gzip_static] = "on"
default[:nginx-i2][:gzip_vary] = "on"
default[:nginx-i2][:gzip_disable] = "MSIE [1-6].(?!.*SV1)"
default[:nginx-i2][:gzip_http_version] = "1.0"
default[:nginx-i2][:gzip_comp_level] = "2"
default[:nginx-i2][:gzip_proxied] = "any"
default[:nginx-i2][:gzip_types] = ["application/x-javascript",
                                "application/xhtml+xml",
                                "application/xml",
                                "application/xml+rss",
                                "text/css",
                                "text/javascript",
                                "text/plain",
                                "text/xml"]
# NGinx will compress "text/html" by default

default[:nginx-i2][:keepalive] = "on"
default[:nginx-i2][:keepalive_timeout] = 65

default[:nginx-i2][:worker_processes] = 10
default[:nginx-i2][:worker_connections] = 1024
default[:nginx-i2][:server_names_hash_bucket_size] = 64

default[:nginx-i2][:proxy_read_timeout] = 60
default[:nginx-i2][:proxy_send_timeout] = 60

include_attribute "nginx::customize"
