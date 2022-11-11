module XlsFunction
  module Extensions
    module HashExtension
      class << self
        # @param [Hash] source
        # @param [Hash] other
        def deep_merge(source, other, &block)
          source.merge(other) do |key, oldval, newval|
            next deep_merge(oldval, newval, &block) if oldval.is_a?(Hash) && newval.is_a?(Hash)
            next block.call(key, oldval, newval) if block_given?

            newval
          end
        end
      end

      refine Hash do
        def deep_merge(other, &block)
          HashExtension.deep_merge(self, other, &block)
        end
      end
    end
  end
end
