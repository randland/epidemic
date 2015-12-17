class Array
  def deep_clone
    self.collect do |val|
      clone_val val
    end
  end

  def move_to_first(index)
    self.deep_clone.move_to_first! index
  end

  def move_to_first!(index)
    raise IndexError unless index >= 0 && index < self.count
    val_to_move = self[index]
    index.times do |n|
      self[index-n] = self[index-n-1]
    end
    self[0] = val_to_move
    self
  end

  def move_to_last(index)
    self.deep_clone.move_to_last! index
  end

  def move_to_last!(index)
    raise IndexError unless index >= 0 && index < self.count
    val_to_move = self[index]
    (self.count-index-1).times do |n|
      self[index+n] = self[index+n+1]
    end
    self[-1] = val_to_move
    self
  end

  private

  def clone_val(val)
    begin
      if val.respond_to? :deep_clone
        val.deep_clone
      elsif val.is_a? Class
        val
      else
        val.clone
      end
    rescue TypeError
      val
    end

  end
end
