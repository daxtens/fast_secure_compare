# shamelessly ripped off https://github.com/cotag/http-parser/blob/master/Rakefile

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

task :default => [:compile, :test]

task :compile do
    protect = ['secure_compare.c', 'secure_compare.h']
    Dir["ext/secure_compare/**/*"].each do |file|
        begin
            next if protect.include? File.basename(file)
            FileUtils.rm file
        rescue
        end
    end
    system 'cd ext && rake'
end

RSpec::Core::RakeTask.new(:test)
