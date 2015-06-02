case node['platform']
when 'debian','ubuntu'
  %w[tar].each do |pkg|
    package pkg do
      action :install
    end
  end
when 'redhat','centos','fedora','scientific','suse','amazon'
  %w[tar].each do |pkg|
    package pkg do
      action :install
    end
  end
end
