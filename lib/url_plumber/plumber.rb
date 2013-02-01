require 'active_support/hash_with_indifferent_access'

module UrlPlumber
  class Plumber
    attr_accessor :params

    def initialize params
      @params = dup(params)
    end

    def plumb key_path, value = nil
      keys = key_path.to_s.split('.').map(&:to_sym)
      key = keys[-1].to_sym

      scopes = []
      scope = dup(params)

      keys[0..-2].each do |part|
        scopes << scope
        scope = scope.fetch(part) { HashWithIndifferentAccess.new }
      end

      if value.nil?
        scope.delete key
      else
        scope[key] = value
      end

      keys[0..-2].reverse.each_with_index do |part|
        parent = scopes.pop
        parent[part] = scope
        scope = parent
      end

      scope
    end

    private
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