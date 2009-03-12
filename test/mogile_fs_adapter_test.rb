require File.join(File.dirname(__FILE__),'test_helper')

class MogileFSAdapterTest < Test::Unit::TestCase
  
  def test_should_write_and_read_and_delete_persistable_objects
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => "tracker.test.de:6001", :class => 'devel')

    data_to_persist = StringIO.new("The answer to all questions.")
    persistable_object_in = mock("PersistableIn")
    persistable_object_in.expects(:persistence_key).returns("42")
    persistable_object_in.expects(:persistence_data).returns(data_to_persist)
    
    connection_in = mock("MogileFS-Connection")
    connection_in.expects(:store_file).with("42", "devel", data_to_persist)
    connection_in.expects(:backend).returns(mock("MockBackend", :shutdown => true))
    MogileFS::MogileFS.expects(:new).at_least_once.with(:domain => "mydomain", :hosts => ["tracker.test.de:6001"], :timeout => 10).returns(connection_in)
    
    adapter.write(persistable_object_in)

    persistable_object_out = mock("PersistableOut")
    persistable_object_out.expects(:persistence_key).returns("42")
    persistable_object_out.expects(:persistence_data=).with() { |data| data.kind_of? StringIO }

    connection_out = mock("MogileFS-Connection")
    connection_out.expects(:get_file_data).with("42").returns(data_to_persist.read)
    connection_out.expects(:backend).returns(mock("MockBackend", :shutdown => true))
    MogileFS::MogileFS.expects(:new).at_least_once.with(:domain => "mydomain", :hosts => ["tracker.test.de:6001"], :timeout => 10).returns(connection_out)
    
    adapter.read(persistable_object_out)    
    
    persistable_object_delete = mock("PersistableOut")
    persistable_object_delete.expects(:persistence_key).returns("42")
    
    connection_delete = mock("MogileFS-Connection")
    connection_delete.expects(:delete).with("42")
    connection_delete.expects(:backend).returns(mock("MockBackend", :shutdown => true))
    MogileFS::MogileFS.expects(:new).at_least_once.with(:domain => "mydomain", :hosts => ["tracker.test.de:6001"], :timeout => 10).returns(connection_delete)
    
    adapter.delete(persistable_object_delete)
  end
  
  def test_should_set_domain_tracker_and_class
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => "tracker.test.de:6001", :class => 'devel')
    assert_equal "devel", adapter.mogile_fs_class
  end
  
  def test_should_set_domain_multiple_tracker_and_class
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => ["tracker1.test.de:6001", "tracker2.test.com:6001"], :class => 'devel')
    assert_equal "devel", adapter.mogile_fs_class
  end
  
  def test_should_set_timeout
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => "tracker.test.de:6001", :class => 'devel', :timeout => 10)
    assert_equal "devel", adapter.mogile_fs_class
  end
  
  def test_should_handle_unknown_key_on_delete_gracefully
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => "tracker.test.de:6001", :class => 'devel')
    connection_delete = mock("MogileFS-Connection")
    persistable_object_delete = mock("PersistableOut")
    persistable_object_delete.expects(:persistence_key).returns("42")
    connection_delete.expects(:delete).raises(MogileFS::Backend::UnknownKeyError)
    connection_delete.expects(:backend).returns(mock("MockBackend", :shutdown => true))
    MogileFS::MogileFS.expects(:new).at_least_once.with(:domain => "mydomain", :hosts => ["tracker.test.de:6001"], :timeout => 10).returns(connection_delete)
    
    assert_equal(false, adapter.delete(persistable_object_delete))
  end
  
  def test_should_return_nil_if_file_was_not_found
    adapter = Persistable::MogileFSAdapter.new(:domain => "mydomain", :tracker => "tracker.test.de:6001", :class => 'devel')
    
    
    persistable_object_out = mock("PersistableOut")
    persistable_object_out.expects(:persistence_key).returns("42")
    persistable_object_out.expects(:persistence_data=).with(nil)
    
    connection_out = mock("MogileFS-Connection")
    connection_out.expects(:get_file_data).with("42").returns(nil)
    connection_out.expects(:backend).returns(mock("MockBackend", :shutdown => true))
    MogileFS::MogileFS.expects(:new).with(:domain => "mydomain", :hosts => ["tracker.test.de:6001"], :timeout => 10).returns(connection_out)
    adapter.read(persistable_object_out)
  end
    
end
