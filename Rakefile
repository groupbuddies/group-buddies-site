unless ENV['RACK_ENV'] == 'production'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  Rake::Task['rubocop'].invoke
  task default: [:rubocop]
end
