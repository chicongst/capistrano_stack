server "node-dev", roles: %w{app}

# set branch
set :branch, :develop

# append config
append :linked_files, '.env'
append :linked_dirs, 'logs', 'node_modules'

# override tasks order
before 'deploy:symlink:release', 'npm:install'
before 'deploy:symlink:release', 'npm:build'
after 'deploy:symlink:release', 'render:restart'
