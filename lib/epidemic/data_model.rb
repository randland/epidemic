module Epidemic
  class DataModel < Hashie::Dash
    include Hashie::Extensions::Dash::Coercion

    private

    def self.load_yaml_config(filename)
      ::Epidemic::ConfigLoader.load_yaml_config filename
    end

    def self.coerce_class(val)
      val.try(:constantize) || val
    end
    def self.is_truthy?(val)
      case val
      when String then !!(val =~ /^(true|t|yes|y|1)$/i)
      when Numeric then !([-1,0].include? val.to_i)
      else val == true
      end
    end

    def self.coerce_objects(val, to: Hashie::Mash, via: :tag)
      case val
      when Array then coerce_objects_from_array val, to: to, via: via
      when Hash then coerce_objects_from_hash val, to: to, via: via
      when String then coerce_objects_from_hash load_yaml_config(val), to: to, via: via
      else empty_coerced_object
      end
    end

    def self.empty_coerced_object
      Hashie::Mash.new
    end

    def self.coerce_objects_from_array(arr, to: Hashie::Mash, via: :tag)
      arr.inject(empty_coerced_object) do |memo, obj|
        hash = case obj
               when Symbol then {via => obj}
               when String then {via => obj}
               else obj
               end
        memo.merge hash[via] => to.new(hash)
      end
    end

    def self.coerce_objects_from_hash(hash, to: Hashie::Mash, via: :tag)
      hash.inject(empty_coerced_object) do |memo, (key, obj)|
        memo.merge key => to.new(obj.merge via => key)
      end
    end
  end

  class ConfigLoader
    @@loaded_configs = {}
    def self.load_yaml_config(filename)
      @@loaded_configs[filename] ||= YAML.load_file(File.expand_path("../../../config/#{filename}.yml", __FILE__))
    end
  end
end
