module XlsFunction
  module Evaluators
    module Functions
      class Switch < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :switch

        MAX_CONDITIONS_COUNT = 126
        MAX_ARGUMENTS_COUNT = 254
        MAX_ARGUMENTS_COUNT.times do |n|
          text_name = :"condition#{n + 1}"
          define_arg text_name
        end

        def condition_of(number)
          send(:"condition#{number}")
        end

        def eval
          arr = Array.new(MAX_ARGUMENTS_COUNT) do |index|
            condition_of(index + 1)
          end

          replace(arr[0], conditions(arr), not_match(arr))
        end

        private

        def conditions(args)
          conditions = items(args)
          condition_all(to_hash(conditions))
        end

        def to_hash(args)
          items = args.length.odd? ? args.pop : args
          Hash[*items]
        end

        def condition_all(args)
          conditions = items(args)
          conditions.keys.length <= MAX_CONDITIONS_COUNT ? conditions : conditions[0..MAX_CONDITIONS_COUNT]
        end

        def items(args)
          return args if args.length.zero?

          args.delete_at(1)
          args
        end

        def not_match(args)
          items = items(args)
          items.length.odd? ? args.last : nil
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
