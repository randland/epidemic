require "epidemic/version"

require "hashie"

require "epidemic/gamestate"
require "epidemic/factories/gamestate_factory"

module Epidemic
  def self.coerce_objects(val, to: Hashie::Mash, via: :tag)
    case val
    when Array then coerce_objects_from_array val, to: to, via: via
    when Hash then coerce_objects_from_hash val, to: to, via: via
    else empty_coerced_object
    end
  end

  private

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

