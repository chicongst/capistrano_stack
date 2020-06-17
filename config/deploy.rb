# config valid only for current version of Capistrano
lock "3.9.0"

set :application, proc { fetch(:stage).split(':').reverse[1] }
set :repo_url, proc { "#{ENV['GIT_SOURCE']}/#{fetch(:application)}.git" }

# Default branch is :develop
set :branch, ENV['branch'] || 'develop'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, proc { "#{ENV['WORKSPACE_PATH']}/#{fetch(:application)}/#{fetch(:branch)}" }

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: "log/#{fetch(:stage).split(':').reverse[1]}.#{fetch(:stage).split(':').reverse[0]}.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

set :log_level, :debug

# Default value for :linked_files is []
# append :linked_files, '.env'

# Default value for linked_dirs is []
# append :linked_dirs, 'storage', 'vendor'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

SSHKit.config.command_map[:chmod] = 'sudo chmod'
SSHKit.config.command_map[:chown] = 'sudo chown'
SSHKit.config.command_map[:cachetool] = 'sudo cachetool'
SSHKit.config.command_map[:supervisorctl] = 'sudo supervisorctl'

if ENV['VIA_BASTION']
  require 'net/ssh/proxy/command'

  # Use a default host for the bastion, but allow it to be overridden
  bastion_host = ENV['BASTION_HOST']

  # Use the local username by default
  bastion_user = ENV['BASTION_USER']

  # Configure Capistrano to use the bastion host as a proxy
  # ssh_command = "ssh -W %h:%p #{bastion_user}@#{bastion_host}"
  ssh_command = "ssh -F ~/.ssh/config mtb"

  set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
end

namespace :deploy do
    after :finished, :cleanup
end
