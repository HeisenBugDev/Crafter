require 'bundler/gem_tasks'

require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Default Task. Run Unit Tests and Build a Gem.'
task :default => [:spec, :build]

