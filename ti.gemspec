# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ti"

Gem::Specification.new do |s|
  s.name          = %q{ti}
  s.version       = Ti.version
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Robert R Evans", "Julius Francisco", "Wynn Netherland", "Rupak Ganguly"]
  s.date          = %q{2011-08-13}
  s.email         = %q{robert@codewranglers.org}
  s.homepage      = %q{http://github.com/codewranglers/ti}
  s.summary       = %q{Ti - A Titanium Rapid Development Framework}
  s.description   = %q{Titanium Rapid Development Framework}
  s.license       = "MIT"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency(%q<coffeefile>,          ["~> 0.0.3"])
  s.add_runtime_dependency(%q<compass>,             ["~> 0.11.5"])
  s.add_runtime_dependency(%q<colored>,             ["~> 1.2"])
  s.add_runtime_dependency(%q<rake>,                ["~> 0.9.2"])
  s.add_runtime_dependency(%q<nokogiri>,            ["~> 1.5.0"])
  s.add_runtime_dependency(%q<erubis>,              ["~> 2.7.0"])
  
  s.add_development_dependency(%q<rocco>,           ["~> 0.8.1"])
end

