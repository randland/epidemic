class Hash
  def deep_clone
    my_clone = self.clone
    my_clone.keys.each do |key|
      my_clone[key] = clone_value key
    end
    my_clone
  end

  def deep_includes? sub_hash
    sub_hash.all? do |key, val|
      if val.respond_to? :deep_includes?
        self[key].deep_includes? val
      elsif val.respond_to? :map
        self[key].zip(val).all? do |target, search|
          if target.respond_to? :deep_includes?
            target.deep_includes? search
          else
            target.to_s == search.to_s
          end
        end
      else
        self[key].to_s == val.to_s
      end
    end
  end

  def deep_diff(b)
    a = self
    (a.keys | b.keys).inject({}) do |diff, k|
      if a[k] != b[k]
        if a[k].respond_to?(:deep_diff) && b[k].respond_to?(:deep_diff)
          diff[k] = a[k].deep_diff(b[k])
        else
          diff[k] = [a[k], b[k]]
        end
      end
      diff
    end
  end

  private

  def clone_value(key)
    orig = self[key]
    begin
      if orig.respond_to? :deep_clone
        orig.deep_clone
      elsif orig.is_a? Class
        orig
      else
        orig.clone
      end
    rescue TypeError
      orig
    end
  end
end
