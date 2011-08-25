unless ::Hash.method_defined?(:symbolize_keys)
  class ::Hash
    def symbolize_keys
      inject({}) { |hash, (key, value)| hash[key.to_s.to_sym] = value; hash }
    end

    def symbolize_keys!
      replace symbolize_keys
    end
  end
end