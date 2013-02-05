# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "persistable/version"

Gem::Specification.new do |s|
  s.name        = "persistable"
  s.version     = Persistable::VERSION
  s.authors     = ["pkw.de development team"]
  s.email       = ["dev@pkw.de"]
  s.homepage    = ""
  s.summary     = %q{Persistence gem for pkw.de images}
  s.description = %q{Defines different ways to store images: file, memory, mogile_fs}

  # s.add_dependency "mogilefs-client", "2.2.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
  s.add_development_dependency "yard"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
