## Application configuration
set :application,             'Project'
set :branch,                  -> { fetch(:stage) }
set :repo_url,    'git@git.shefcompsci.org.uk:com3420-2023-24/team17/project.git'
set :linked_files,            fetch(:linked_files,  fetch(:env_links, [])).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs,             fetch(:linked_dirs, []).push('log', 'tmp/pids', 'public/packs', 'node_modules', 'storage')

## Ruby configuration
set :rvm_type,                    :system
set :rvm_ruby_version,            'ruby-3.1'
set :rvm_path,                    '/usr/local/rvm'

# Currently Passenger is installed against the 'default' Ruby version
# This may change in future, but can be customised here
set :passenger_rvm_ruby_version,  'default'

## Capistrano configuration
set :log_level,     :info
set :pty,           true
set :keep_releases, 2


# Set up any other necessary configurations and roles



namespace :deploy do
  ## Capistrano has removed the task deploy:migrations which epiDeploy calls
  task :migrations do
    invoke 'deploy'
  end
end

Rake::Task["deploy:assets:backup_manifest"].clear_actions

## Restart delayed_job during the deployment process
# after  'deploy:updated',  'delayed_job:stop'
# before 'deploy:finished', 'delayed_job:start'
