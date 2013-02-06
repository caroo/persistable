require "fog"

module Persistable
  ##
  # CloudStorageAdapter powered by the fog gem
  class CloudStorageAdapter

    ##
    # @!attribute [r] options
    # @return [Hash] Options used during the object initialization
    attr_reader :options

    ##
    # Creates a new `CloudStorageAdapter`
    # @param options [Hash] `hash` with options for this adapter
    # @option options [Symbol] :provider One of the providers given
    #   by {http://http://fog.io/storage/ fog gem}
    # @option options [String] :directory The directory to save the files to,
    #   e.g. file system directory, amazon s3 bucket, ...
    # @option options [Hash] :provider_options Provider options needed
    #   for {http://http://fog.io/storage/ fog gem} storage providers
    def initialize(options = {})
      @options = options
      available_providers = Fog::Storage.providers
      available_providers.include?(provider) or raise ArgumentError, "Unknown Fog::Storage provider. Should be on of \
       #{available_providers.inspect}, given provider"
      directory_name or raise ArgumentError, "Directory to save file should be given."
      check_connection
    end

    ##
    # Write the data given by `#persisence_data` method to the cloud
    # @param persistable [#persistance_key, #persistance_data] Any object responding to the methods needed
    # @return [Boolean] Returns the success status of this operation
    def write(persistable)
      if persistable.persistence_data
        return directory.files.create(:key => persistable.persistence_key, :body => persistable.persistence_data)
      end
      return false
    end

    ##
    # Reads the data on the cloud and write it on the `persistance_data` property of `persistable` object
    # @param persistable (@see #write)
    # @return (@see #write)
    def read(persistable)
      if file = directory.files.get(persistable.persistence_key)
        persistable.persistence_data = StringIO.new(file.body)
        return true
      end
      false
    end

    ##
    # Deletes file named `persistable#persistance_key` from storage
    # @param persistable (@see #write)
    # @return (@see #write)
    def delete(persistable)
      if file = directory.files.head(persistable.persistence_key)
        return file.destroy
      end
      false
    end

    private

    def connection
      @connection ||= Fog::Storage.new provider_options
    end
    alias check_connection connection

    def directory
      @directory ||= connection.directories.get(directory_name) || connection.directories.create(:key => directory_name)
    end

    def directory_name
      @directory_name ||= options[:directory]
    end

    def provider
      @provider ||= options[:provider].to_sym
    end

    def provider_options
      options[:provider_options].merge({:provider => options[:provider]}).symbolize_keys
    end

  end
end