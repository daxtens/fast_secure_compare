Gem::Specification.new do |s|
  s.name        = 'secure_compare'
  s.version     = '0.0.0'
  s.date        = '2010-08-14'
  s.summary     = "A fast, simple way to do constant time string comparisons."
  s.description = "A fast, simple way to do constant time string comparisons."
  s.authors     = ["Daniel Axtens"]
  s.email       = 'daniel@axtens.net'
  s.files       = ["lib/secure_compare/secure_compare.rb"]
  s.homepage    =
    'http://rubygems.org/gems/secure_compare'
  s.license       = 'MIT'


  s.add_dependency 'ffi-compiler', '>= 0.0.2'
  s.add_dependency 'rake'

  s.add_development_dependency 'rspec'
  
  s.files = Dir["{lib}/**/*"] + %w(Rakefile secure_compare.gemspec) # README.md LICENSE)
  s.files += ["ext/secure_compare/secure_compare.c"]#, #"ext/http-parser/http_parser.h"]
  s.test_files = Dir["spec/**/*"]
  #s.extra_rdoc_files = ["README.md"]

  s.extensions << "ext/Rakefile"
  s.require_paths = ["lib"]
end

