Chef::Log.info "Installing npm packages"

Chef::Log.info "Installing bower"
    execute "bower-install" do
        command "npm install bower -g"
        action :run
    end

Chef::Log.info "Installing Grunt"
    execute "grunt-install" do
        command "npm install grunt grunt-cli -g"
        action :run
    end

Chef::Log.info "Installing forever"
    execute "forever-install" do
        command "npm install forever -g"
        action :run
    end

