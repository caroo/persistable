require "test_helper"

require 'test_helper'
require 'persistable/cloud_storage_adapter'
require 'fileutils'

class CloudStorageTest < Test::Unit::TestCase
  def test_write_file
    persistable = get_persistable
    persistable.persistence_data = File.open(__FILE__)
    assert adapter.write persistable
    assert_true File.exist?(file_path)
  end

  def test_read_file
    prepare_file
    persistable = get_persistable
    assert adapter.read persistable
    assert persistable.persistence_data
    assert_equal persistable.persistence_data, File.read(file_path)
  end

  def test_read_not_existent_path
    assert_nothing_raised do
      delete_file
      persistable = get_persistable
      assert_false adapter.read persistable
      assert_nil persistable.persistence_data
    end
  end

  def assert_delete
    prepare_file
    persistable = get_persistable
    assert_true adapter.delete persistable
    assert_false File.exist?(file_path)
  end

  def test_initializer_should_check_provider
    assert_raise ArgumentError do
      Persistable::CloudStorageAdapter.new(:provider => :now_known_provider)
    end
  end

  def test_initializer_should_check_directory_name
    assert_raise ArgumentError do
      Persistable::CloudStorageAdapter.new(:provider => :aws)
    end
  end

  def test_initializer_should_not_raise_errors_if_all_required_options_given
    assert_nothing_raised do
      Persistable::CloudStorageAdapter.new(valid_options)
    end
  end

  private

  def get_persistable
    persistable = PersistableClass.new
    persistable.persistence_key = "my_file_name"
    persistable
  end

  def file_path
    '/tmp/my_storage_dir/my_file_name'
  end

  def delete_file
    FileUtils.rm_f file_path
  end

  def prepare_file
    FileUtils.cp __FILE__, file_path
    assert_true File.exist?(file_path)
  end

  def adapter
    Persistable::CloudStorageAdapter.new valid_options
  end

  def valid_options
    {
      :provider => :local,
      :directory => 'my_storage_dir',
      :provider_options => {
        :local_root => '/tmp'
      }
    }
  end
end