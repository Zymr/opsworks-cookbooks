include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  #if deploy[:application_type] != 'nodejs'
  #  Chef::Log.debug("Skipping deploy::nodejs for application #{application} as it is not a node.js app")
  #  next
  #end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  #opsworks_nodejs do
  #  deploy_data deploy
  #  app application
  #end

  application_environment_file do
    user deploy[:user]
    group deploy[:group]
    path ::File.join(deploy[:deploy_to], "shared")
    environment_variables deploy[:environment_variables]
  end

  execute "npm_install on iframely" do
      command "npm install"
      cwd "#{deploy[:deploy_to]}/current/iframely"
  end

  execute "pm2 start in iframely" do
      command "pm2 start server.js"
      cwd "#{deploy[:deploy_to]}/current/iframely"
  end

  execute "npm_install on canvas.services" do
      command "npm install"
      cwd "#{deploy[:deploy_to]}/current/canvas.services"
  end

  execute "npm_install Zmq on canvas.services" do
      command "npm install zmq"
      cwd "#{deploy[:deploy_to]}/current/canvas.services"
  end

  execute "pm2 start in canvas.services" do
      command "pm2 start server.js"
      cwd "#{deploy[:deploy_to]}/current/canvas.services"
  end

  #ruby_block "restart node.js application #{application}" do
  #  block do
  #    Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
  #    Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
  #    $? == 0
  #  end
  #end
  #ruby_block "Run bower install" do
  #    block do
  #        Chef::Log.info("running bower install in")
  #        execute "bower_install" do
  #            command "bower install --allow-root"
  #            cwd "#{deploy[:deploy_to]}/current/canvas.presentation/app"
              #action "run"
              #user "root"
  #        end
  #    end
  #end
end
