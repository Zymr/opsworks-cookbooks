include_recipe 'aerospike::_install_prereqs'
include_recipe 'ulimit::default'
include_recipe 'aerospike::install' unless node['aerospike']['bypass_setup']

template node['aerospike']['config_path'] do
  source 'aerospike.conf.erb'
  mode 0644
  variables namespaces: node['aerospike']['namespaces']
  notifies :restart, 'service[aerospike]'
end

service 'aerospike' do
  supports [:start, :retsart, :status]
  action [:start]
end

