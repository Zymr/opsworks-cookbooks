default['aerospike']['version'] = '3.5.9'
default['aerospike']['config_path'] = '/etc/aerospike/aerospike.conf'

case node['platform']
when 'ubuntu'
  default['aerospike']['tarball_url'] = "http://aerospike.com/download/server/#{node['aerospike']['version']}/artifact/ubuntu12"
  default['aerospike']['checksum'] = '29b5e592349811738269a2b79b578b723942c0ef2682b2c514fbdda6df9ba621'
when 'debian'
  case node['platform_version']
  when '6'
    default['aerospike']['tarball_url'] = "http://aerospike.com/download/server/#{node['aerospike']['version']}/artifact/debian6"
    default['aerospike']['checksum'] = '41d2b43b862470c99a5b71d98a6089a61bc32e14685a052d3d0191e4d9f1af93'
  when '7'
    default['aerospike']['tarball_url'] = "http://aerospike.com/download/server/#{node['aerospike']['version']}/artifact/debian7"
    default['aerospike']['checksum'] = '2dacf055d49e62d8be0a2508c11334a52a95982dc8389a7a93d36019d600c32c'
  end
when 'centos', 'redhat', 'scientific', 'amazon', 'suse'
  default['aerospike']['tarball_url'] = "http://aerospike.com/download/server/#{node['aerospike']['version']}/artifact/el6"
  default['aerospike']['checksum'] = 'cf4d41edc7215dd190b3590f1273b483c8be6e692c1a1d0dd55951234eafa75c'
else
  default['aerospike']['tarball_url'] = "http://aerospike.com/download/server/#{node['aerospike']['version']}/artifact/tgz"
  default['aerospike']['checksum'] = 'c78622acc1e2bcd9e6d914bf19819b40d69f454827a1e15fe68e24b0788f8c5a'
  default['aerospike']['config_path'] = nil
end

default['aerospike']['base_name'] = 'aerospike-'
default['aerospike']['artifact_type'] = 'tgz'
default['aerospike']['namespaces'] = [{ name: 'test' }, { name: 'bar' }]
