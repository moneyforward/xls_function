module XlsFunction
  module FormatString
    module Evaluators
      # @todo refactoring...
      # rubocop:disable Metrics/AbcSize
      class NumberEvaluator
        attr_reader :parts

        def initialize(parts)
          @parts = parts
        end

        def call(input)
          extract_parts!(input)
          value = adjust_value(input)
          format_value(value)
        rescue ArgumentError
          input
        end

        def interger_parts
          @interger_parts ||= PartsList.new
        end

        def decimal_parts
          @decimal_parts ||= PartsList.new
        end

        def parts_length
          @parts_length ||= parts.length
        end

        def extract_parts!(input)
          parts_target = interger_parts

          comma_index = []
          @parts.each_with_index do |expr, i|
            if expr.respond_to?(:digits?)
              parts_target.add_parts(expr, i, true)
              next
            end

            # evaluate except number placeholder
            str = expr.call(input)
            # switch stack when decimal point comes
            parts_target = decimal_parts if str == '.'
            # count comma
            if str == ','
              comma_index << i
              # ignore
              next
            end
            # last % is parcentage flag
            @has_parcentage = true if str == '%' && (i == parts_length - 1)

            parts_target.add_parts(str, i, false)
          end.compact
          check_comma(comma_index)
        end

        # ↓ check comma
        # When % exists, check 2 or 1 chars before from %.
        # If not, check last 2 or 1 chars.
        def comma_index_pattern_thousands
          offset = @has_parcentage ? 2 : 1
          [parts_length - offset]
        end

        def comma_index_pattern_millions
          offset = @has_parcentage ? 2 : 1
          [parts_length - offset - 1, parts_length - offset]
        end

        def check_comma(comma_index)
          return if comma_index.empty?

          if (comma_index_pattern_millions - comma_index).empty?
            @unit = :millions
            @format = true unless (comma_index - comma_index_pattern_millions).empty?
          elsif (comma_index_pattern_thousands - comma_index).empty?
            @unit = :thousands
            @format = true unless (comma_index - comma_index_pattern_thousands).empty?
          else
            @format = true
          end
        end

        def adjust_value(value)
          decimal_value = value.to_s.to_d

          case @unit
          when :millions
            decimal_value /= '1000000'.to_d
          when :thousands
            decimal_value /= '1000'.to_d
          end

          decimal_value *= '100'.to_d if @has_parcentage

          decimal_value
        end

        def format_value(value)
          value_stack = ValueStack.new(value, decimal_parts.size, @format)

          # format decimals
          decimal_chars =
            create_dec_pair(decimal_parts, value_stack).reverse
                                                       .then { |value_pairs| eval_pairs(value_pairs) }
                                                       .reverse
                                                       .join

          # format integers
          integer_chars =
            create_int_pair(interger_parts, value_stack).reverse
                                                        .then { |value_pairs| eval_pairs(value_pairs, int_remain: value_stack.int_remain?) }
                                                        .join

          "#{!value_stack.empty? ? value_stack.to_s : ''}#{integer_chars}#{decimal_chars}"
        end

        def create_dec_pair(parts_list, value_stack)
          parts_list.parts_with_index.map do |part, index|
            if parts_list.num?(index)
              [value_stack.shift_dec, part]
            else
              [part, nil] # means already evaluated
            end
          end
        end

        def create_int_pair(parts_list, value_stack)
          parts_list.parts_with_index.reverse.map do |part, index|
            if parts_list.num?(index)
              [value_stack.pop_int, part]
            else
              [part, nil]
            end
          end
        end

        def eval_pairs(value_eval_pairs, int_remain: false)
          require_zero = false
          value_eval_pairs.map do |value, eval|
            next value unless eval

            evaluated_value = eval.call(value)
            if evaluated_value.strip != '' && evaluated_value != '0'
              require_zero = true
              next evaluated_value
            end

            # `#` returns empty if zero but must return zero if higher place exists.
            next '0' if evaluated_value == '' && (require_zero || int_remain)

            evaluated_value
          end
        end
      end
      # rubocop:enable Metrics/AbcSize

      class PartsList
        attr_reader :parts_with_index

        def initialize
          @parts_with_index = []
          @num_indexies = []
        end

        def add_parts(part, index, is_num)
          @parts_with_index << [part, index]
          @num_indexies << index if is_num
        end

        def num?(index)
          @num_indexies.include?(index)
        end

        def size
          parts_with_index.size
        end
      end

      # decomposes a number and takes from last.
      class ValueStack
        def initialize(source, dec_digit, format)
          # reduce 1 because dec_digit include decimal point.
          # call to_d because round(0) in ruby 3.0 returns integer.
          value = dec_digit.positive? ? source.round(dec_digit - 1).to_d : source.round(0).to_d
          str = value.to_s('F')
          int, dec = str.split('.')

          @ints = format ? int_split_with_comma(int) : int.split('')
          @decs = dec_digit.positive? ? dec.split('') : []
        end

        def int_split_with_comma(int_s)
          result = []
          count = 0
          arr = int_s.split('')
          length = arr.length
          length.times do |i|
            result.unshift(arr.pop)
            count += 1
            next if count < 3 || i == length - 1

            result.unshift(',')
            count = 0
          end
          result
        end

        def pop_int
          s = @ints.pop
          return s unless @ints.last == ','

          # return with comma if exists
          @ints.pop + s
        end

        def shift_dec
          @decs.shift
        end

        def empty?
          @ints.empty? && @decs.empty?
        end

        def int_remain?
          @ints.filter { |x| x != '-' }
               .any?
        end

        def to_s
          s = @ints.join
          return s if @decs.empty? || @decs == ['0']

          "#{s}.#{@decs.join}"
        end
      end
    end
  end
end
