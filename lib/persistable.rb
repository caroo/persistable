$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'persistable/fs_adapter'
require 'persistable/memory_adapter'
require 'persistable/mogile_fs_adapter'
require 'persistable/factory'

module Persistable
  VERSION = "0.4.1"
end