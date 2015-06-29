#
# Cookbook Name:: canvas
# Recipe:: default
#
# Copyright 2015, Zymr, Inc.
#
# All rights reserved - Do Not Redistribute
#

#template "config.js" do
#  path "#{node[:canvasweb][:dir]}/config.js"
#  source "config.js.erb"
#  owner "root"
#  group "root"
#  mode 0644
#end

file "#{node[:canvasweb][:dir]}/index.html" do
    owner 'root'
    group 'root'
    mode 0644
    content ::File.open("#{node[:canvasweb][:dir]}/index.html.testkanvz").read
    action :create
end

file "#{node[:canvasweb][:dir]}/config.js" do
    owner 'root'
    group 'root'
    mode 0644
    content ::File.open("#{node[:canvasweb][:dir]}/config.js.testkanvz").read
    action :create
end

