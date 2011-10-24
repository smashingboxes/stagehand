# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stagehand/version"

Gem::Specification.new do |s|
  s.name        = "stagehand"
  s.version     = Stagehand::VERSION
  s.authors     = ["Reed Law"]
  s.email       = ["reed@smashingboxes.com.com"]
  s.homepage    = "https://github.com/smashingboxes/stagehand"
  s.summary     = %q{client library for Personas (user management) service}
  s.description = %q{Client-side library for manipulating RESTful resources provided by Personas, a Rails + Backbone user managment service}

  s.rubyforge_project = "stagehand"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency 'rspec', '~> 2.7.0'
  s.add_runtime_dependency 'yajl-ruby', '~> 1.0.0'
end
