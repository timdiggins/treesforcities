set :default_stage, "production"

require 'capistrano/ext/multistage'
require 'spacesuit/recipes/multistage_patch'
require 'spacesuit/recipes/common'
#require 'config/recipes/passenger'
#require 'config/recipes/monit'

set :application, "treemap"
set :rails_env, "production"
set :ssh_options, {:forward_agent => true}
set :use_sudo, false

default_run_options[:pty] = true
set :scm, "git"
set :branch, "master"
set :repository,  "git@github.com:red56/treesforcities.git"
set :keep_releases, 30
set :git_enable_submodules, 1


#override restart for passenger
deploy.task :restart, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end

