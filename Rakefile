require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rake/extensiontask'

task :default => [:compile, :test]
spec = eval(File.read('fast_secure_compare.gemspec'))
# add your default gem packing task
Gem::PackageTask.new(spec) do |pkg|
end

# feed the ExtensionTask with your spec
Rake::ExtensionTask.new('fast_secure_compare', spec)

RSpec::Core::RakeTask.new(:test)
