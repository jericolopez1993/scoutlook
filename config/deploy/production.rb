# Change these
# server 'ubuntu@scoutlook.opinionated.software', roles: [:web, :app, :db, :worker, :prod], primary: true
# server 'ubuntu@99.79.186.43', roles: [:web, :app, :db, :non_worker, :prod]
server 'ubuntu@99.79.132.191', roles: [:web, :app, :db, :worker, :prod], primary: true

set :repo_url,        'https://github.com/jericolopez1993/scoutlook.git'
set :git_http_username, 'jericolopez0107'
set :git_http_password, 'wV46GnmfW2WHPsp8'
set :application,     'scout_prod'
set :user,            'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :delayed_job_workers, 2
set :branch, ENV.fetch('REVISION', 'master')
set :rvm_ruby_version, '2.6.0'
# set :branch, ENV.fetch('REVISION', 'SC_Carrier_Ajax')
set :ssh_options, paranoid: false


# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(scoutlook.pem) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :keep_releases, 1
set :linked_dirs, %w{public/system storage}
set :whenever_environment, ->{ "#{fetch(:stage)}" }
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
