require 'mogilefs'

module Persistable
  class MogileFSAdapter
    
    attr_reader :mogile_fs_class, :options
    
    
    def initialize(options = {})
      @options = options
      @mogile_fs_class = options[:class]
    end
    
    def write(persistable)
      hosts = options[:tracker].is_a?(String) ? [options[:tracker]] : options[:tracker]
      connection = MogileFS::MogileFS.new(:domain => options[:domain], :hosts => hosts, :timeout => options[:timeout] ? options[:timeout] : 10)
      status = connection.store_file(persistable.persistence_key, mogile_fs_class, persistable.persistence_data)
      connection.backend.shutdown
      status
    end
    
    def read(persistable)
      hosts = options[:tracker].is_a?(String) ? [options[:tracker]] : options[:tracker]
      connection = MogileFS::MogileFS.new(:domain => options[:domain], :hosts => hosts, :timeout => options[:timeout] ? options[:timeout] : 10)
      begin
        if data = connection.get_file_data(persistable.persistence_key)
          persistable.persistence_data = StringIO.new(data)
        else
          persistable.persistence_data = nil
        end
      rescue MogileFS::Backend::UnknownKeyError, MogileFS::Backend::NoKeyError => e
        persistable.persistence_data = nil
      ensure
        connection.backend.shutdown
      end
    end
    
    def delete(persistable)
      hosts = options[:tracker].is_a?(String) ? [options[:tracker]] : options[:tracker]
      connection = MogileFS::MogileFS.new(:domain => options[:domain], :hosts => hosts, :timeout => options[:timeout] ? options[:timeout] : 10)
      begin
        status = connection.delete(persistable.persistence_key)  
      rescue MogileFS::Backend::UnknownKeyError => e
        status = false
      ensure
        connection.backend.shutdown
      end

      status
    end
    
  end
end