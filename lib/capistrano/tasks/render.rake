namespace :render do
  task :restart do
    on roles :app do
      invoke 'pm2:app:restart', ["dist/src/main.js"]
    end
  end
end
