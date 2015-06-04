include_recipe 'aerospike::_install_prereqs'
include_recipe 'ulimit::default'

aerospike_install 'aerospike-installation'

service 'aerospike' do
  provider Chef::Provider::Service::Init
  action :start
end
