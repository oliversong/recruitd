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

set :user, "capistrano"
set :password, "capdev123"
set :domain, "rails.mit.edu"
set :port, "22"
server domain, :app, :web
role :db, domain, :primary => true


# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'deployer'
set :scm_password, 'p@ssw0rd'
set :repository, "git@github.com:mit6470/keone.git"
#set :deploy_via, :remote_cache

#############################################################
#	Passenger
#############################################################

after "deploy:update_code", "deploy:write_db_yaml"

namespace :deploy do
  
  desc "Create the database yaml file"
  task :write_db_yaml do
    db_config = <<-EOF
    development:
      adapter: mysql
      encoding: utf8
      database: recruitd_development
      username: recruitd
      password: recruitd89dev!
    #   adapter: sqlite3
    #   database: db/link/development.sqlite3
    #   pool: 5
    #   timeout: 5000
    #   
    production:
      adapter: mysql
      encoding: utf8
      database: recruitd_production
      username: recruitd
      password: recruitd89dev!
    #   adapter: sqlite3
    #   database: db/link/production.sqlite3
    #   pool: 5
    #   timeout: 5000
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
    run "ln -s #{shared_path}/db #{release_path}/db/link"
    
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
  
  # namespace :deploy do
  #     task :start do ; end
  #     task :stop do ; end
  #     task :restart, :roles => :app, :except => { :no_release => true } do
  #       run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  #     end
  #   end
  
end
