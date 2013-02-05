require "fog"

module Persistable
  class CloudStorageAdapter

    attr_reader :options

    def initialize(options = {})
      @options = options
      available_providers = Fog::Storage.providers
      available_providers.include?(provider) or raise ArgmentError, "Unknown Fog::Storage provider. Should be on of \
       #{available_providers.inspect}, given provider"
      directory_name or raise ArgumentError, "Directory to save file should be given."
    end

    def write(persistable)
      directory.files.create(:key => persistable.persistence_key, :body => persistable.persistence_data)
    end

    def read(persistable)
      if file = directory.files.get(persistable.persistence_key)
        persistable.persistence_data = file.body
      end
    end

    def delete(persistable)
      if file = directory.files.head(persistable.persistence_key)
        file.destroy
      end
    end

    private
    def connection
      @connection ||= Fog::Strorage.new provider_options
    end

    def directory
      @directory ||= connection.directories.get(directory_name)
    end

    def directory_name
      @directory_name ||= options[:directory]
    end

    def provider
      @provider ||= options[:provider].to_sym
    end

    def provider_options
      options[:provider_options].merge({:provider => options[:provider]}).sumbolize_keys
    end

  end
end