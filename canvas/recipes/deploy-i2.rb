include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

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

end
