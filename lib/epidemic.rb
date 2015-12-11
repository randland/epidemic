require "hashie"
require "active_support/all"
require "epidemic/extensions"
require "epidemic/version"
require "epidemic/gamestate"
require "epidemic/services"

module Epidemic
  def self.is_truthy?(val)
    case val
    when String then !!(val =~ /^(true|t|yes|y|1)$/i)
    when Numeric then !val.to_i.zero?
    else val == true
    end
  end

  def self.coerce_class(val)
    val.try(:constantize) || val
  end

  def self.coerce_objects(val, to:, via:)
    case val
    when Array then coerce_objects_from_array val, to: to, via: via
    when Hash then coerce_objects_from_hash val, to: to, via: via
    else empty_coerced_object
    end
  end

  def self.empty_coerced_object
    Hashie::Mash.new
  end

  def self.coerce_objects_from_array(arr, to:, via:)
    arr.inject(empty_coerced_object) do |memo, obj|
      memo.merge obj[via] => to.new(obj)
    end
  end

  def self.coerce_objects_from_hash(hash, to:, via:)
    hash.inject(empty_coerced_object) do |memo, (key, obj)|
      memo.merge key => to.new(obj.merge via => key)
    end
  end
end
