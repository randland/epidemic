require 'epidemic/extensions/clone_helpers'

class Array
  include Epidemic::Extensions::CloneHelpers

  def deep_clone
    self.collect {|val| clone_val val}
  end

  def unique_permutations
    return [] if self.empty?
    return [self] if self.length == 1
    first_perm = [self.first]
    rest_perms =  self[1..-1].unique_permutations.reject &:empty?
    merged_perms = rest_perms.collect {|perm| first_perm + perm}
    result = [[],first_perm] + merged_perms + rest_perms
    result.sort do |a,b|
      comp = a.length <=> b.length
      a.zip(b).inject(comp) do |c, (v1, v2)|
        c.zero? ? v1 <=> v2 : c
      end
    end
  end

  def paired_with_each(other)
    Enumerator.new(self.count * other.count) do |y|
      self.each do |my_val|
        other.each do |other_val|
          y.yield [my_val, other_val]
        end
      end
    end
  end
end
