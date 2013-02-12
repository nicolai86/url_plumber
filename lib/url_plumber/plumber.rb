require "active_support/hash_with_indifferent_access"

module UrlPlumber
  class Plumber
    attr_accessor :params

    def initialize params
      @params = dup(params)
    end

    def extract key_path
      keys = key_path.to_s.split('.').map(&:to_sym)
      key = keys[-1]

      scope = params
      keys[0..-2].each do |part|
        scope = scope.fetch(part) { HashWithIndifferentAccess.new }
      end

      if scope.has_key?(key)
        scope[key]
      else
        nil
      end
    end

    def plumb attributes = {}
      scope = dup(params)
      attributes.each do |key, value|
        scope = update_scope scope, key, value
      end
      scope
    end

    def update_scope scope, key_path, value = nil
      keys = key_path.to_s.split('.').map(&:to_sym)
      key = keys[-1]

      scopes = []

      keys[0..-2].each do |part|
        scopes << scope
        scope = scope.fetch(part) { HashWithIndifferentAccess.new }
      end

      if value.nil?
        scope.delete key
      else
        scope[key] = value
      end

      keys[0..-2].reverse.each do |part|
        parent = scopes.pop
        parent[part] = scope
        scope = parent
      end

      scope
    end

    private
    # params.dup returns the original request parameters in Ruby on Rails
    # so we need to get our hands dirty to create an actual copy of the params
    def dup hash
      new_hash = ::HashWithIndifferentAccess.new
      hash.each do |key, value|
        if value.is_a?(Hash)
          new_hash[key] = dup(value)
        else
          new_hash[key] = value
        end
      end
      return new_hash
    end
  end
end