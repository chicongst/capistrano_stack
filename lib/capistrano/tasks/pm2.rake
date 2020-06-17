require 'json'

namespace :pm2 do
  def app_status(app_name)
    within current_path do
      ps = []
      begin
        ps = JSON.parse(capture :pm2, :jlist)
      rescue => exception
      end

      ps.each do |child|
        if child['name'] == app_name
          return child['pm2_env']['status']
        end
      end

      return nil
    end
  end

  namespace :app do
    # pm2 start
    task :start, :command do  |task, args|
      server_name = args[:command][0]
      on roles :app do
        app_name = fetch(:application)
        params = [
            "pm2 start #{fetch(:deploy_to)}/current/#{server_name}",
            "--name=#{app_name}",
            "--cwd=#{fetch(:deploy_to)}/current",
            "-i max",
            "--output=#{fetch(:deploy_to)}/shared/logs/access.log",
            "--error=#{fetch(:deploy_to)}/shared/logs/error.log",
            '--log-date-format "YYYY-MM-DD HH:mm Z"'
        ]
        execute params.join(' ')
      end
    end

    task :restart, :command do  |task, args|
      app_name = fetch(:application)
      server_name = args[:command]
      on roles :app do
        case app_status(app_name)
        when nil
          info 'App is not registerd'
          invoke 'pm2:app:start', server_name
        else
          execute :pm2, 'restart ' + app_name
        end
      end
    end

    # pm2 ls
    task :list do
      on roles :app do
        execute :pm2, 'ls'
      end
    end

    task :status do
      on roles :app do
        app_name = fetch(:application)
        case app_status(app_name)
        when nil
          info 'App is not registerd'
        else
          info 'App is registerd'
        end
      end
    end

  end
end
