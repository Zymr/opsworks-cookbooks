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

  execute "bower_install" do
      command "bower install --allow-root"
      cwd "#{deploy[:deploy_to]}/current/canvas.presentation/app"
  end

end
