include_recipe 'aerospike::_install_prereqs'
include_recipe 'ulimit::default'
include_recipe 'aerospike::install' unless node['aerospike']['bypass_setup']
