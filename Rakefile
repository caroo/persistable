%w[hoe rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/persistable'

Hoe.plugin :newgem
Hoe.plugins.delete :rubyforge
Hoe.plugins.delete :test
$hoe = Hoe.spec('persistable') do |p|
  p.developer('Caroo GmbH', 'dev@pkw.de')
  p.post_install_message = File.read('PostInstall.txt')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.extra_dev_deps = [
    ['mocha'],
    
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
  p.extra_deps = [
    ['mogilefs-client', ">= 2.0.2"],
    ['activesupport', ">= 2.3.2"]
  ]
  p.summary = "Persistable is a library for persisting IO-Data into any storage you like. It provides adapters for in-memory storage, file storage and mogile-fs but can be easily extended with your own adapters."
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
end

require 'newgem/tasks'

desc "Run unit tests"
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
  t.warning = true
end

desc 'Generate RDoc'
Rake::RDocTask.new do |task|
  task.main = 'README.rdoc'
  task.title = "Persistable #{Persistable::VERSION}"
  task.rdoc_dir = 'doc'
  task.rdoc_files.include('README.rdoc', 'COPYING', 'MIT-LICENSE', "lib/persistable/*.rb")
end
