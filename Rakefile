require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rake/extensiontask'

task :default => [:compile, :test]

spec = Gem::Specification.new do |s|
  s.name        = 'fast_secure_compare'
  s.version     = '0.1.0'
  s.date        = '2014-08-21'
  s.summary     = "A fast, simple way to do constant time string comparisons."
  s.description = "A secure_comparison function implemented in C for blazing speed."
  s.authors     = ["Daniel Axtens"]
  s.email       = 'daniel@axtens.net'
  s.homepage    =
    'https://github.com/daxtens/fast_secure_compare'
  s.license       = 'MIT'


  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler'
  s.add_development_dependency 'rspec'

  s.files = Dir["{lib}/**/*"] + %w(Rakefile README.md LICENSE)
  s.files += Dir['ext/**/*.c'] + Dir['ext/**/extconf.rb']
  s.test_files = Dir["spec/**/*"]
  s.extra_rdoc_files = ["README.md"]

  s.extensions = Dir['ext/**/extconf.rb']
  s.require_paths = ["lib"]
end

# add your default gem packing task
Gem::PackageTask.new(spec) do |pkg|
end

# feed the ExtensionTask with your spec
Rake::ExtensionTask.new('fast_secure_compare', spec)

RSpec::Core::RakeTask.new(:test)
