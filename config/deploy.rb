module Capistrano::DSL
  def invoke(task, *args)
    Rake::Task[task].invoke(*args)
    Rake::Task[task].reenable
  end
end

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :nginx do
    %w(start stop restart reload).each do |command|
        desc "#{command.capitalize} Nginx"
        task command do
            on roles(:app) do
                execute :sudo, "service nginx #{command}"
            end
        end
    end
end

namespace :cron do
    %w(start stop restart reload).each do |command|
        desc "#{command.capitalize} CRON"
        task command do
            on roles(:non_worker) do
                execute :sudo, "service cron #{command}"
            end
        end
    end
end

namespace :seed do
  desc "Backup the database based on environment"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/seeds -p"
    end
  end

  task :dump do
    on roles(:app) do
      execute "cd #{release_path} && /usr/local/rvm/bin/rvm default do bundle exec rake db:seed:dump EXCLUDE=[] FILE=#{shared_path}/seeds/#{Date.now}-seeds.rb RAILS_ENV=#{fetch(:stage)}"
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master` || `git rev-parse HEAD` == `git rev-parse origin/development`
        puts "WARNING: HEAD is not the same as origin/master or origin/development"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Start Nginx'
  task :start_nginx do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'nginx:start'
    end
  end

  desc 'Stop Nginx'
  task :stop_nginx do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'nginx:stop'
    end
  end

  desc 'Restart Nginx'
  task :restart_nginx do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'nginx:restart'
    end
  end

  desc 'Stop Cron'
  task :stop_cron do
    on roles(:non_worker), in: :sequence, wait: 5 do
      invoke 'cron:stop'
    end
  end

  desc 'Kill Crons'
  task :kill_cron do
    on roles(:prod), in: :sequence, wait: 5 do
      execute "kill $(ps aux | grep '[d]elayed_job' | awk '{print $2}')"
    end
  end

  desc 'Seed Dump'
  task :seed_dump do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'seed:make_dirs'
      invoke 'seed:dump'
    end
  end

  before :starting,     :stop_nginx
  # before :starting,     :seed_dump
  before :starting,     :check_revision
  before :starting,     :kill_cron
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finishing,    :stop_cron
  # after  :finishing,    :restart_nginx
  after  :finishing,    :start_nginx
  # after  :finishing,    :seed_dump
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
