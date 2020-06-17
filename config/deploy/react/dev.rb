server "react-dev", roles: %w{app}

# set branch
set :branch, :develop

# append config
append :linked_files, '.env'
append :linked_dirs, 'node_modules'

# override tasks order
before "deploy:symlink:release", "react:compile_assets"
after 'deploy:symlink:release', 'frontend:restart'
