module UrlPlumber
  class Plumber
    attr_accessor :params

    def initialize params
      @params = dup(params)
    end

    def plumb key_path, value = nil
      key_path = key_path.split('.')
      key = key_path[-1]

      scopes = []
      scope = dup(params)

      key_path[0..-2].each do |part|
        scopes << scope
        scope = scope.fetch(part) { Hash.new }
      end

      if value.nil?
        scope.delete key
      else
        scope[key] = value
      end

      key_path[0..-2].reverse.each_with_index do |part|
        parent = scopes.pop
        parent[part] = scope
        scope = parent
      end

      scope
    end

    private
    def dup hash
      new_hash = HashWithIndifferentAccess.new
      hash.each do |key, value|
        new_hash[key] = value.dup
      end
      return new_hash
    end
  end
end