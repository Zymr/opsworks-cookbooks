#
# Cookbook Name:: canvas
# Recipe:: default
#
# Copyright 2015, Zymr, Inc.
#
# All rights reserved - Do Not Redistribute
#

template "aerospike_config.js" do
  path "#{node[:canvasapp][:dir]}/aerospike_config.js"
  source "aerospike_config.js.erb"
  owner "root"
  group "root"
  mode 0644
end

template "config.js" do
  path "#{node[:canvasappconfig][:dir]}/config.js"
  source "i2-config.js.erb"
  owner "root"
  group "root"
  mode 0644
end

