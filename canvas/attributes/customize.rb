
default[:opsworks][:deploy_user][:shell] = '/bin/bash'
default[:opsworks][:deploy_user][:user] = 'root'
default[:opsworks][:deploy_user][:group] = 'root'
default[:opsworks][:deploy_user][:home] = '/root'
default[:opsworks][:deploy_keep_releases] = 5
default[:opsworks][:deploy_chef_provider] = 'Timestamped'

default[:deploy] = {}
node[:deploy].each do |application, deploy|
    default[:deploy][application][:deploy_to] = "/srv/www/"
    default[:deploy][application][:user] = node[:opsworks][:deploy_user][:user]
    default[:deploy][application][:group] = node[:opsworks][:deploy_user][:group]
    default[:deploy][application][:shell] = node[:opsworks][:deploy_user][:shell]
    default[:deploy][application][:home] = if !node[:opsworks][:deploy_user][:home].nil?
                                               node[:opsworks][:deploy_user][:home]
                                           else
                                               "/root"
                                           end
    default[:deploy][application][:chef_provider] = node[:deploy][application][:chef_provider] ? node[:deploy][application][:chef_provider] : node[:opsworks][:deploy_chef_provider]
    #unless valid_deploy_chef_providers.include?(node[:deploy][application][:chef_provider])
    #    raise "Invalid chef_provider '#{node[:deploy][application][:chef_provider]}' for app '#{application}'. Valid providers: #{valid_deploy_chef_providers.join(', ')}."
    #end
    default[:deploy][application][:keep_releases] = node[:deploy][application][:keep_releases] ? node[:deploy][application][:keep_releases] : node[:opsworks][:deploy_keep_releases]
    #default[:deploy][application][:document_root] = ''
    #default[:deploy][application][:current_path] = "#{node[:deploy][application][:deploy_to]}/current"
    #default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/"
    #default[:deploy][application][:absolute_document_root] = "#{default[:deploy][application][:current_path]}/#{deploy[:document_root]}/"
    default[:deploy][application][:action] = 'deploy'
    default[:deploy][application][:environment] = {"DEPLOY_PATH" => node[:deploy][application][:deploy_to]}
    default[:deploy][application][:environment_variables] = {}
    default[:deploy][application][:ssl_support] = false
    default[:deploy][application][:auto_npm_install_on_deploy] = true
    default[:deploy][application][:migrate] = false
    default[:deploy][application][:migrate_command] = ''

    default[:deploy][application][:sleep_before_restart] = 0
    default[:deploy][application][:stack][:needs_reload] = true
    default[:deploy][application][:enable_submodules] = true
    default[:deploy][application][:shallow_clone] = false
    default[:deploy][application][:delete_cached_copy] = true
    default[:deploy][application][:purge_before_symlink] = ['log', 'tmp/pids', 'public/system']
    default[:deploy][application][:create_dirs_before_symlink] = ['tmp', 'public', 'config']
    default[:deploy][application][:symlink_before_migrate] = {}
    default[:deploy][application][:symlinks] = {"system" => "public/system", "pids" => "tmp/pids", "log" => "log"}
    # nodejs
    #default[:deploy][application][:nodejs][:restart_command] = "monit restart node_web_app_#{application}"
    #default[:deploy][application][:nodejs][:stop_command] = "monit stop node_web_app_#{application}"
    #default[:deploy][application][:nodejs][:port] = deploy[:ssl_support] ? 443 : 80
end
