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

  directory "#{deploy[:deploy_to]}/current/deploy" do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
  end

  template "before_restart.rb" do
      path "#{deploy[:deploy_to]}/current/deploy/before_restart.rb"
      source "before_restart.rb.erb"
      owner "root"
      group "root"
      mode 0777
  end

#  file "#{deploy[:deploy_to]}/current/canvas.presentation/app/index.html" do
#      owner 'root'
#      group 'root'
#      mode 0644
#      content ::File.open("#{deploy[:deploy_to]}/current/canvas.presentation/app/index.html.testkanvz").read
#      action :create
#  end

 # file "#{deploy[:deploy_to]}/current/canvas.presentation/app/config.js" do
 #     owner 'root'
 #     group 'root'
 #     mode 0644
 #     content ::File.open("#{deploy[:deploy_to]}/current/canvas.presentation/app/config.js.testkanvz").read
 #     action :create
 # end
end
