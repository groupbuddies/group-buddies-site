set :repo_url, 'git@github-gb-site:groupbuddies/group-buddies-site.git'
set :application, 'gb-site'
set :stage, :production
set :branch, (ENV['DEPLOY_BRANCH'] || :master)
set :rack_env, :production

set :format, :pretty
set :log_level, :debug
set :pty, true

set :rvm_ruby_version, '2.2.0'

set :linked_files, %w(.env)
set :linked_dirs, %w(log)

set :bundle_without, %w(development test deploy).join(' ')
set :keep_releases, 1

set :foreman_export_path, '/home/deploy/.init'
set :foreman_options, {
  user: 'deploy',
  procfile: 'Procfile.production'
}

namespace :deploy do
  task :stop do
    begin
      invoke 'foreman:stop'
    rescue
    end
  end

  desc 'Restart application'
  task :restart do
    invoke 'deploy:stop'
    invoke 'foreman:export'
    invoke 'foreman:start'
  end

  task :assets do
    on release_roles(:all) do
      within release_path do
        with rack_env: fetch(:rack_env) do
          execute :rake, 'assetpack:build'
        end
      end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:assets'
  after :finishing, 'deploy:restart'
end
