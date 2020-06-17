server "laravel-stg", roles: %w{app db}

# set branch
set :branch, :staging

# append config
append :linked_files, '.env'
append :linked_dirs, 'storage', 'vendor'

# override tasks order
before "deploy:symlink:release", "composer:install"
after "composer:install", "laravel:permissions"
after "laravel:permissions", "laravel:clear_config"
after "laravel:clear_config", "laravel:migrate"
after "laravel:migrate", "supervisor:restart"
