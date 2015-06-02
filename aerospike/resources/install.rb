actions :run

default_action :run

attribute :version, kind_of: String, default: node['aerospike']['version']
attribute :tarball_url, kind_of: String, default: node['aerospike']['tarball_url']
attribute :download_dir, kind_of: String, default: Chef::Config[:file_cache_path]
attribute :artifact_type, kind_of: String, default: 'tgz'
attribute :install_dir, kind_of: String, default: nil
attribute :base_name, kind_of: String, default: 'aerospike-'
