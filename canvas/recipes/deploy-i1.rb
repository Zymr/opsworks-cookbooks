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

  execute "bower_install" do
      command "bower install --allow-root"
      cwd "#{deploy[:deploy_to]}/current/canvas.presentation/app"
  end

  execute "npm_install" do
      command "npm install"
      cwd "#{deploy[:deploy_to]}/current/canvas.presentation"
  end

  execute "grunt_build" do
      command "grunt build:sslkanvz"
      cwd "#{deploy[:deploy_to]}/current/canvas.presentation"
  end

end
