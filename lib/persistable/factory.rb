module Persistable
  ##
  # Factory class to help to define particular adapters.
  # @deprecated This class has a strange API, so in the future a new API will be provided
  class Factory

    ##
    # Builds a new adapter
    # @param yml_file_path [String] the path to the config path in yml format.
    #   This file should include a `Hash` with a key `:adapter`, which is a `Hash` itself.
    #   The latter hash should contain a field named `type` specifying the adapter type.
    #   The adapter type is one of ['filesystem', 'mogilefs', 'memory', 'cloud']
    # @param defaults [Hash={}] Hash with default values for given adapter. Those values will be reverse merged
    #   with values taken from yml file. The whole method is still useful just because of this param.
    #   Usually you will specify all values using `defaults` and leaving `yml_file_path` empty.
    # @return [Adapter] Returns one of the adapter instances specified by the `type` option
    def self.build(yml_file_path, defaults = {})
      adapter_config = load_yml(yml_file_path, defaults)
      raise ArgumentError.new("Invalid Parameter: There should be a Hash with :adapter key.") unless adapter_config[:adapter]
      adapter_config = adapter_config[:adapter].symbolize_keys
      raise ArgumentError.new("Invalid Parameter: There should be a Hash with :type key.") unless adapter_config[:type]

      adapter = case adapter_config.delete(:type)
      when 'filesystem'
        require "persistable/fs_adapter"
        Persistable::FSAdapter.new(adapter_config)
      when 'mogilefs'
        require "persistable/mogile_fs_adapter"
        Persistable::MogileFSAdapter.new(adapter_config)
      when 'memory'
        require "persistable/memory_adapter"
        Persistable::MemoryAdapter.new(adapter_config)
      when 'cloud'
        require "persistable/cloud_storage_adapter"
        Persistable::CloudStorageAdapter.new(adapter_config)
      end

      return adapter
    end

    ##
    # Loads the config from a yml file and returns the values as a `Hash`
    # @param yml_file_path (@see #build)
    # @param defaults (@see #build)
    # @return [Hash] options needed to build an adapter
    def self.load_yml(yml_file_path, defaults = {})
      defaults.merge!(YAML.load_file(yml_file_path).symbolize_keys) if yml_file_path && File.exists?(yml_file_path)
      return defaults
    end

  end
end