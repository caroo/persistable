require 'rubygems'
require 'test/unit'
require 'mocha/setup'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))

require File.dirname(__FILE__) + '/../lib/persistable'