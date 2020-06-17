namespace :supervisor do

  desc "Restart all process (supervisorctl)"
  task :restart do
    on roles(:app) do
      execute :supervisorctl, "restart all"
    end
  end
end
