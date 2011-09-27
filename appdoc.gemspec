# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "appdoc/version"

Gem::Specification.new do |s|
  s.name        = "appdoc"
  s.version     = Appdoc::VERSION
  s.authors     = ["Ryan Hall"]
  s.email       = ["ryan.e.hall@biola.edu"]
  s.homepage    = "https://github.com/biola/appdoc"
  s.summary     = %q{Documentation for your app}
  s.description = %q{Allows you to add documents and documentation to your app}

  s.rubyforge_project = "appdoc"

  s.files         = Dir["{app,lib,config}/**/*"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("action_links", ">= 0.1.0")
  s.add_dependency("acts-as-taggable-on", ">= 2.0.0")
  s.add_dependency("haml", ">= 3.0.0")
  s.add_dependency("kaminari", ">= 0.10.0")
  s.add_dependency("meta_search", ">= 1.0.0")
end
