module Epidemic
  class NilBehavior < Hashie::Mash
    def self.execute!(*args)
      self.new(*args).execute
    end

    def execute!(*args)
    end
  end
end
