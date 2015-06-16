
default[:opsworks][:deploy_user][:shell] = '/bin/bash'
default[:opsworks][:deploy_user][:user] = 'root'
default[:opsworks][:deploy_user][:group] = 'root'
default[:deploy] = {}
node[:deploy].each do |application, deploy|
    default[:deploy][application][:deploy_to] = "/srv/www/"
    default[:deploy][application][:chef_provider] = node[:deploy][application][:chef_provider] ? node[:deploy][application][:chef_provider] : node[:opsworks][:deploy_chef_provider]
    unless valid_deploy_chef_providers.include?(node[:deploy][application][:chef_provider])
        raise "Invalid chef_provider '#{node[:deploy][application][:chef_provider]}' for app '#{application}'. Valid providers: #{valid_deploy_chef_providers.join(', ')}."
    end
    #default[:deploy][application][:document_root] = ''
    #default[:deploy][application][:current_path] = "#{node[:deploy][application][:deploy_to]}/current"
    #default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/"
    #default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/#{deploy[:document_root]}/"
    default[:deploy][application][:action] = 'deploy'
    default[:deploy][application][:environment] = {"DEPLOY_PATH" => node[:deploy][application][:deploy_to]}
    default[:deploy][application][:environment_variables] = {}
    default[:deploy][application][:ssl_support] = false
    default[:deploy][application][:auto_npm_install_on_deploy] = true
    # nodejs
    #default[:deploy][application][:nodejs][:restart_command] = "monit restart node_web_app_#{application}"
    #default[:deploy][application][:nodejs][:stop_command] = "monit stop node_web_app_#{application}"
    #default[:deploy][application][:nodejs][:port] = deploy[:ssl_support] ? 443 : 80
end
