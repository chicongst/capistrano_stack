server "react-prod-1", roles: %w{app}
server "react-prod-2", roles: %w{app}

# set branch
set :branch, :master

# append config
append :linked_files, '.env'
append :linked_dirs, 'node_modules'

# override tasks order
before "deploy:symlink:release", "react:compile_assets"
after 'deploy:symlink:release', 'frontend:restart'
