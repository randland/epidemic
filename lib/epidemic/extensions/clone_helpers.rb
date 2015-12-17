module Epidemic
  module Extensions
    module CloneHelpers
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
  end
end
