action :run do
  if current_resource.version != new_resource.version || !aerospike_exists?
    Chef::Log.info("Installing Aerospike #{new_resource.version} from source")
    download
    unpack
    install
  end
  new_resource.updated_by_last_action(true)
end

def download
  Chef::Log.info("Downloading Aerospike from #{new_resource.tarball_url}")
  #Chef::Log.info("Downloading Aerospike from http://www.aerospike.com/artifacts/aerospike-server-community/3.5.9/aerospike-server-community-3.5.9-ubuntu12.04.tgz")
  #Chef::Log.info("Downloading Aerospike from https://s3-us-west-2.amazonaws.com/canvas-software/aerospike-server-enterprise-3.5.12-ubuntu12.04.tgz")
  remote_file download_path do
    source new_resource.tarball_url
    #source "http://www.aerospike.com/artifacts/aerospike-server-community/3.5.9/aerospike-server-community-3.5.9-ubuntu12.04.tgz"
    #source "https://s3-us-west-2.amazonaws.com/canvas-software/aerospike-server-enterprise-3.5.12-ubuntu12.04.tgz"
    checksum new_resource.checksum
  end
end

def unpack
  case new_resource.artifact_type
  when 'tar.gz', 'tgz'
    execute %(cd #{new_resource.download_dir} ; mkdir -p '#{install_dir}' ; tar zxf '#{download_path}' --strip-components=1 -C '#{install_dir}')
  else
    raise Chef::Exceptions::UnsupportedAction, "Current package type #{new_resource.artifact_type} is unsupported"
  end
end

def install
  execute "cd #{new_resource.download_dir}/#{install_dir} && ./asinstall"
  new_resource.updated_by_last_action(true)
end

def aerospike_exists?
  ::File.exists?('/usr/bin/asd')
end

def version
  if aerospike_exists?
    bin_path = '/usr/bin/asd'
    aerospike_version = Mixlib::ShellOut.new("#{bin_path} --version")
    aerospike_version.run_command
    version = aerospike_version.stdout[/build (\d*.\d*.\d*)/,1]
    Chef::Log.info("The Aerospike server version is: #{version}")
    return version.gsub("\n",'')
  end
  nil
end

def install_dir
  "#{new_resource.base_name}#{new_resource.version}"
end

def download_path
  "#{new_resource.download_dir}/#{new_resource.base_name}#{new_resource.version}.#{new_resource.artifact_type}"
end

def load_current_resource
  @current_resource = Chef::Resource::AerospikeInstall.new(new_resource.name)
  @current_resource.version(version)
  @current_resource
end
