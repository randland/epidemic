class String
  def snakify
    self.underscore.downcase.gsub(/\W+/, '_')
  end
end
