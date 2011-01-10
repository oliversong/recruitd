#############################################################
#	Application
#############################################################

set :application, "recruitd"
set :deploy_to, "/var/www/cap-deploy/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production" 

#############################################################
#	Servers
#############################################################

server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################


set :scm, :git
set :user, "deployer"
set :scm_passphrase, "p@ssw0rd"
set :repository, "git@github.com:6470/keone.git"
set :branch, "master"
set :deploy_via, :remote_cache

#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    # db_config = <<-EOF
    # production:    
    #   adapter: mysql
    #   encoding: utf8
    #   username: root
    #   password: 
    #   database: bort_production
    #   host: localhost
    # EOF
    # 
    # put db_config, "#{release_path}/config/database.yml"
    
    # authlogic_config = <<-EOF
    # connect:
    #   twitter:
    #     key: MurjMwwfB7UOvYrA6Hg9Q
    #     secret: KMdY9YrNodzaNyVLdpPtTpCctWKAaFgN7Ah6AjgV7co
    #     label: "Twitter"
    #   facebook:
    #     key: 7f7242d747c9b081c2fe89b05d25b771
    #     secret: b496e5b2ee1a763ab13aa83e037b0f3f
    #     label: "Facebook"
    #   google:
    #     key: "my_key"
    #     secret: "my_secret"
    #     label: "Google"
    #   yahoo:
    #     key: "my_key"
    #     secret: "my_secret"
    #     label: "Yahoo"
    # EOF
    # 
    # put authlogic_config, "#{release_path}/config/authlogic.yml"
    
    #########################################################
    # Uncomment the following to symlink an uploads directory.
    # Just change the paths to whatever you need.
    #########################################################
    
    # desc "Symlink the upload directories"
    # task :before_symlink do
    #   run "mkdir -p #{shared_path}/uploads"
    #   run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    # end
  
  end
    
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end
