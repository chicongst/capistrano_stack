namespace :react do
  task :compile_assets do
    on roles(:app) do
      within release_path do
        execute :yarn, :install
        execute :yarn, :start
      end
    end
  end
end
