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

file "#{deploy[:deploy_to]}/current/canvas.presentation/app/index.html" do
    owner 'root'
    group 'root'
    mode 0644
    content ::File.open("#{deploy[:deploy_to]}/current/canvas.presentation/app/index.html.testkanvz").read
    action :create
end

file "#{deploy[:deploy_to]}/current/canvas.presentation/app/config.js" do
    owner 'root'
    group 'root'
    mode 0644
    content ::File.open("#{deploy[:deploy_to]}/current/canvas.presentation/app/config.js.testkanvz").read
    action :create
end
