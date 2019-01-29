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

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
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

  before :starting,     :stop_nginx
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
  after  :finishing,    :start_nginx
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
