# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{persistable}
  s.version = "0.5.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Caroo GmbH"]
  s.date = %q{2011-05-05}
  s.description = %q{Persistable is a library for persisting IO-Data into any storage you like. It provides adapters for in-memory storage, file storage and mogile-fs but can be easily extended with your own adapters.

Persistable has been harvested from project pkw.de[http://pkw.de] of {Caroo GmbH}[http://caroo.com].}
  s.email = ["dev@pkw.de"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt"]
  s.files = ["COPYING", "History.txt", "MIT-LICENSE", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/persistable.rb", "lib/persistable/factory.rb", "lib/persistable/fs_adapter.rb", "lib/persistable/memory_adapter.rb", "lib/persistable/mogile_fs_adapter.rb", "persistable.gemspec", "test/factory_test.rb", "test/fs_adapter_test.rb", "test/memory_adapter_test.rb", "test/mogile_fs_adapter_test.rb", "test/test_helper.rb"]
  s.post_install_message = %q{To use the MogileFSAdapter you need the mogilefs-client. Install it via RubyGems

  $ sudo gem install mogilefs-client}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{persistable}
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Persistable is a library for persisting IO-Data into any storage you like. It provides adapters for in-memory storage, file storage and mogile-fs but can be easily extended with your own adapters.}
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mogilefs-client>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<newgem>, [">= 1.5.3"])
      s.add_development_dependency(%q<hoe>, [">= 2.9.4"])
    else
      s.add_dependency(%q<mogilefs-client>, [">= 2.0.2"])
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<newgem>, [">= 1.5.3"])
      s.add_dependency(%q<hoe>, [">= 2.9.4"])
    end
  else
    s.add_dependency(%q<mogilefs-client>, [">= 2.0.2"])
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<newgem>, [">= 1.5.3"])
    s.add_dependency(%q<hoe>, [">= 2.9.4"])
  end
end
