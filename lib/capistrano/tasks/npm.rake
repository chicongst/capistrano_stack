namespace :npm do

  desc "Run npm install task"
  task :install do
    on roles(:app) do
      within release_path do
        execute :npm, 'install'
      end
    end
  end

  desc "Run npm start task"
  task :start do
    on roles(:app) do
      within release_path do
        execute :npm, 'start'
      end
    end
  end

  desc "Run npm build task"
  task :build do
    on roles(:app) do
      within release_path do
        execute :npm, "run build"
      end
    end
  end
end
