namespace :laravel do

  desc "Run Artisan migrate task"
  task :migrate do
    on roles(:db) do
      within release_path do
        execute :php, 'artisan migrate', '--force'
      end
    end
  end

  desc "Run Artisan db:seed task"
  task :seed do
    on roles(:db) do
      within release_path do
        execute :php, 'artisan db:seed'
      end
    end
  end

  desc "Run Artisan cache:clear task"
  task :clear_cache do
    on roles(:app) do
      within release_path do
        execute :php, 'artisan cache:clear'
      end
    end
  end

  desc "Run Artisan config:clear task"
  task :clear_config do
    on roles(:app) do
      within release_path do
        execute :php, 'artisan config:clear'
      end
    end
  end

  desc "Run Artisan clear-compiled & optimize task"
  task :optimize do
    on roles(:app) do
      within release_path do
        execute :php, 'artisan clear-compiled'
        execute :php, 'artisan optimize'
      end
    end
  end

  desc "Create Storage directories & Set permissions task"
  task :permissions do
    on roles(:app) do
      within release_path do

        execute :chmod, '-R ug+rwx storage'
        execute :chmod, '-R ug+rwx bootstrap/cache' if test("[ -d #{release_path}/bootstrap/cache ]")
        execute :chown, '-RH ubuntu:www-data storage'
        execute :chown, '-RH ubuntu:www-data bootstrap/cache' if test("[ -d #{release_path}/bootstrap/cache ]")
      end
    end
  end
end
