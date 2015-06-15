
default[:opsworks][:deploy_user][:shell] = '/bin/bash'
default[:opsworks][:deploy_user][:user] = 'root'
default[:opsworks][:deploy_user][:group] = 'root'
default[:deploy][application][:deploy_to] = "/srv/www/#{application}"
#default[:deploy][application][:document_root] = ''
#default[:deploy][application][:current_path] = "#{node[:deploy][application][:deploy_to]}/current"
#default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/#{deploy[:document_root]}/"
default[:deploy][application][:auto_npm_install_on_deploy] = true
