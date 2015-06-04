name             'aerospike'
maintainer       'Vlad Gorodetsky'
maintainer_email 'v@gor.io'
license          'Apache 2.0'
description      'Installs/Configures aerospike'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.15'

%w[debian ubuntu centos redhat fedora scientific suse amazon].each do |os|
  supports os
end

recipe 'aerospike::default', 'This recipe is used to install the prequisites for building and installing aerospike, as well as provides the LWRPs'
recipe 'aerospike::install', 'This recipe is used to install aerospike'

depends 'ulimit'
