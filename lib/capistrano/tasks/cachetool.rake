namespace :cachetool do

  desc "Reset opcache"
  task :opcache_reset do
    on roles(:app) do
      execute :cachetool, "opcache:reset --fcgi=/run/php/php7.2-fpm.sock"
    end
  end
end
