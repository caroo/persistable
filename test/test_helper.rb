require 'rubygems'
require 'test/unit'
require 'mocha/setup'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

require 'persistable'

class PersistableClass
  attr_accessor :persistence_data, :persistence_key
end