namespace :frontend do
  task :restart do
    on roles :app do
      invoke 'pm2:app:restart', ["server.js"]
    end
  end
end
