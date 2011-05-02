require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'


require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name        = "ti"
  gem.homepage    = "http://github.com/revans/ti"
  gem.license     = "MIT"
  gem.summary     = %Q{Ti}
  gem.description = %Q{Titanium Project Generator}
  gem.email       = "robert@codewranglers.org"
  gem.authors     = ["Robert R Evans", "Julius Francisco", 'Wynn Netherland']
  gem.date        = "2011-04-16"
  gem.executables = ["ti"]
  gem.version     = File.read(File.join(File.dirname(__FILE__), 'VERSION')).chomp
   
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ti #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
