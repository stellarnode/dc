# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'dc'
set :repo_url, 'git@github.com:domochat/dc.git'
set :ruby_version, '2.2.3'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/#{fetch(:application)}"
set :keep_releases, 5

set :rails_env, -> { fetch(:stage) }
set :scm, :git # Default value for :scm is :git
set :format, :pretty # Default value for :format is :pretty
set :log_level, :info # Default value for :log_level is :debug

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :linked_files, %w{config/application.yml config/database.yml config/secrets.yml}

# rbenv config
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby,  -> { fetch(:ruby_version) }
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# crono config
set :crono_pid, -> { File.join(shared_path, 'tmp', 'pids', 'crono.pid') }
set :crono_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
set :crono_log, -> { File.join(shared_path, 'log', 'crono.log') }
set :crono_role, -> { :app }

namespace :deploy do
  desc "Setup server"
  task :setup do
    puts '--------------------------> Initial server config'
    invoke 'admin:friendly_github'
    invoke 'admin:check_write_permissions'
    invoke 'admin:setup_configs'
  end



  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end


######### Administration part


namespace :admin do
  desc "Report Uptimes"
  task :uptime do
    on roles(:all) do |host|
      info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
    end
  end

  desc "Add github to ~/.ssh/known_hosts"
  task :friendly_github do
    on roles(:all) do |host|
      execute 'ssh-keyscan', '-t rsa', '-H github.com >> ~/.ssh/known_hosts'
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end

  desc "Creates initial templates for server-side configs."
  task :setup_configs do
    on roles(:app) do |host|
      unless test "[ -d #{ shared_path }/config ]"
        execute 'mkdir', "-p #{ shared_path }/config"
      end

      unless test "[ -f #{ shared_path }/config/database.yml ]"
        puts '--------------> Create config/database.yml'
        set :db_driver, ask('Enter the database driver', 'postgresql')
        set :db_database, ask('Enter database', "#{fetch(:application)}_#{fetch(:stage)}")
        set :db_user, ask('Enter the database user:', 'db_user')
        set :db_password, ask('Enter the database password:', nil, echo: false)
        set :db_host, ask('Enter the database host:', 'localhost')

        if fetch(:db_driver) == 'postgis'

          database_yml = <<-EOF
#{fetch(:stage)}:
  adapter: #{fetch(:db_driver)}
  encoding: unicode
  pool: 5
  database: #{fetch(:db_database)}
  host: #{fetch(:db_host)}
  username: #{fetch(:db_user)}
  password: #{fetch(:db_password)}
  schema_search_path: public, postgis
          EOF

        else

          database_yml = <<-EOF
#{fetch(:stage)}:
  adapter: #{fetch(:db_driver)}
  encoding: unicode
  pool: 5
  database: #{fetch(:db_database)}
  host: #{fetch(:db_host)}
  username: #{fetch(:db_user)}
  password: #{fetch(:db_password)}
          EOF

        end



        upload! StringIO.new(database_yml), "#{shared_path}/config/database.yml"
      end

      unless test "[ -f #{ shared_path }/config/secrets.yml ]"
        puts '--------------> Upload config/secrets.yml'

        secrets_yml = <<-EOF
#{fetch(:stage)}:
  secret_key_base: #{SecureRandom.hex(64)}
        EOF


        upload! StringIO.new(secrets_yml), "#{ shared_path }/config/secrets.yml"
      end

      unless test "[ -f #{ shared_path }/config/application.yml ]"
        puts '--------------> Upload config/application.yml'
        upload! 'config/application.yml', "#{ shared_path }/config/application.yml"
      end

      puts '---------------------------------------------------'
      puts "Now edit the config files in #{shared_path}/config."
    end
  end
end