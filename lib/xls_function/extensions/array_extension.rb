module XlsFunction
  module Extensions
    module ArrayExtension
      class << self
        def max_depth(array, depth = 1)
          array.inject(depth) do |current_depth, item|
            next current_depth unless item.is_a?(Array)

            child_depth = max_depth(item, depth + 1)
            [current_depth, child_depth].max
          end
        end
      end

      refine Array do
        def max_depth(depth = 1)
          ArrayExtension.max_depth(self, depth)
        end
      end
    end
  end
end
