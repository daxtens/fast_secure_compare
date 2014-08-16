Gem::Specification.new do |s|
  s.name        = 'fast_secure_compare'
  s.version     = '0.0.1'
  s.date        = '2010-08-17'
  s.summary     = "A fast, simple way to do constant time string comparisons."
  s.description = "A secure_comparison function implemented in C for blazing speed."
  s.authors     = ["Daniel Axtens"]
  s.email       = 'daniel@axtens.net'
  s.homepage    =
    'https://github.com/daxtens/fast_secure_compare'
  s.license       = 'MIT'


  s.add_dependency 'ffi-compiler', '>= 0.0.2'
  s.add_dependency 'rake'

  s.add_development_dependency 'rspec'
  
  s.files = Dir["{lib}/**/*"] + %w(Rakefile fast_secure_compare.gemspec README.md) # LICENSE)
  s.files += ["ext/fast_secure_compare/secure_compare.c"]
  s.test_files = Dir["spec/**/*"]
  s.extra_rdoc_files = ["README.md"]

  s.extensions << "ext/Rakefile"
  s.require_paths = ["lib"]
end

