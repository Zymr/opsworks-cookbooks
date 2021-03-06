#
# Cookbook Name:: zeromq
# Recipe:: install_from_source
#
# Copyright (C) 2013 Johannes Plunien
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel', 'fedora'
  package 'openssl-devel'
  if node['zeromq']['version'] =~ /^2\..*/
    package 'libuuid-devel'
  end
when 'debian', 'ubuntu'
  package 'libssl-dev'
  if node['zeromq']['version'] =~ /^2\..*/
    package 'uuid-dev'
  end
end

zeromq_tar = "zeromq-#{node['zeromq']['version']}.tar.gz"
zeromq_tar_path = "/usr/local/src/#{zeromq_tar}"
zeromq_src_url = "#{node['zeromq']['src_url']}/#{zeromq_tar}"
zeromq_src_dir = "/usr/local/src/zeromq-#{node['zeromq']['version']}"

remote_file zeromq_tar_path do
  source zeromq_src_url
  checksum node['zeromq']['sha256_sum']
  mode 0644
  action :create_if_missing
end

directory zeromq_src_dir do
  action :create
end

execute "tar --no-same-owner -zxf #{zeromq_tar} -C #{zeromq_src_dir} --strip-components 1" do
  cwd "/usr/local/src"
  creates File.join(zeromq_src_dir, 'configure')
end

execute 'zeromq compile and install' do
  environment({'PATH' => '/usr/local/bin:/usr/bin:/bin'})
  command "./configure --prefix=#{node['zeromq']['dir']} --without-libsodium && make && make install"
  cwd zeromq_src_dir
  creates File.join(node['zeromq']['dir'], 'lib', node['zeromq']['creates'])
end

template '/etc/ld.so.conf.d/zeromq.conf' do
  group 'root'
  mode '0444'
  owner 'root'
end

execute 'ldconfig' do
  action :nothing
  command 'ldconfig'
  subscribes :run, 'template[/etc/ld.so.conf.d/zeromq.conf]', :immediately
end
