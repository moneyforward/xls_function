module XlsFunction
  module Evaluators
    module Functions
      class Switch < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :switch

        MAX_ARGUMENTS_COUNT = 254
        MAX_ARGUMENTS_COUNT.times do |n|
          text_name = :"condition#{n + 1}"
          define_arg text_name
        end

        def condition_of(number)
          send(:"condition#{number}")
        end

        def eval
          replace(condition_of(1), conditions(items), not_match(items))
        end

        private

        def conditions(args)
          args.delete_at(0)
          args.length.odd? ? args.pop : args
          to_hash(args)
        end

        def items
          items = []
          MAX_ARGUMENTS_COUNT.times do |n|
            items << condition_of(n + 1)
          end
          items.compact!
          items
        end

        def to_hash(args)
          Hash[*args]
        end

        def not_match(args)
          args.delete_at(1)
          args.length.odd? ? args.last : nil
        end

        def replace(source, conditions, not_match)
          conditions.each do |condition, value|
            return value if source == condition
          end
          not_match.nil? ? ::XlsFunction::ErrorValue.na : not_match
        end
      end
    end
  end
end
