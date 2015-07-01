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

  execute "Stop Node processes" do
      command "pm2 delete all && pm2 kill"
  end

  execute "npm_install on iframely" do
      command "npm install"
      cwd "#{deploy[:deploy_to]}/current/iframely"
  end

  execute "pm2 start in iframely" do
      command "pm2 start server.js --name \"iframely\" -i 0 --watch"
      cwd "#{deploy[:deploy_to]}/current/iframely"
  end

  execute "npm_install on canvas.services" do
      command "npm install"
      cwd "#{deploy[:deploy_to]}/current/canvas.services"
  end

  #execute "npm_install Zmq on canvas.services" do
  #    command "npm install zmq"
  #    cwd "#{deploy[:deploy_to]}/current/canvas.services"
  #end

  file "#{deploy[:deploy_to]}/current/canvas.services/modules/aerospike/aerospike_config.js" do
      owner 'root'
      group 'root'
      mode 0644
      content ::File.open("#{deploy[:deploy_to]}/current/canvas.services/modules/aerospike/aerospike_config.js.testkanvz").read
      action :create
  end

  file "#{deploy[:deploy_to]}/current/canvas.services/config/config.js" do
      owner 'root'
      group 'root'
      mode 0644
      content ::File.open("#{deploy[:deploy_to]}/current/canvas.services/config/config.js.testkanvz").read
      action :create
  end

  execute "pm2 start in canvas.services" do
      command "pm2 start server.js --name \"services\" -i 0 --watch"
      cwd "#{deploy[:deploy_to]}/current/canvas.services"
  end

end
