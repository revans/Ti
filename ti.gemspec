# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ti/version"

Gem::Specification.new do |s|
  s.name          = %q{ti}
  s.version       = Ti::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Robert R Evans", "Julius Francisco", "Wynn Netherland", "Rupak Ganguly"]
  s.date          = %q{2011-05-23}
  s.email         = %q{robert@codewranglers.org}
  s.homepage      = %q{http://github.com/codewranglers/ti}
  s.summary       = %q{Ti - A Titanium Rapid Development Framework}
  s.description   = %q{Titanium Rapid Development Framework}
  s.license       = "MIT"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Currently we're not using these. However, I'd prefer to use these instead of
  # using the system command
  # s.add_runtime_dependency(%q<sass>,                ["~> 3.1.2"])
  s.add_runtime_dependency(%q<coffee-script>,       ["~> 2.2.0"])

  s.add_runtime_dependency(%q<colored>,             ["~> 1.2"])
  s.add_runtime_dependency(%q<rake>,                ["~> 0.8.7"]) # TODO: test with Rake 0.9.2
  s.add_runtime_dependency(%q<nokogiri>,            ["~> 1.4.4"])
  s.add_runtime_dependency(%q<erubis>,              ["~> 2.7.0"])
  s.add_runtime_dependency(%q<rocco>,               ["~> 0.7"])
  s.add_runtime_dependency(%q<thor>,                ["~> 0.14.6"])
  s.add_runtime_dependency(%q<rocco>,               ["~> 0.7"])
  s.add_runtime_dependency(%q<compass>,             ["~> 0.7"])
  s.add_runtime_dependency(%q<session>,             ["~> 3.1"])

  s.add_development_dependency(%q<bundler>,         ["~> 1.0.14"])
  s.add_development_dependency(%q<rspec>,           ["~> 2.6.0"])
end

