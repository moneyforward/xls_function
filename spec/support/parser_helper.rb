module ParserHelper
  # @see https://github.com/kschiess/parslet/blob/655f0c3c0bd2ebcf528a9a616597b41c1d148c77/lib/parslet/slice.rb
  def stub_slice(position: nil, line_cache: nil, **key_value)
    pos = position || Parslet::Position.new('', 0)
    key_value.transform_values { |v| Parslet::Slice.new(pos, v, line_cache) }
  end

  def expected_digits(str, use_stub_slice: false)
    str.split('').map do |s|
      hash =
        case s
        when '#'
          expr(:number, digit_s: '#')
        when '?'
          expr(:number, digit_q: '?')
        when '0'
          expr(:number, digit_z: '0')
        else
          expr(:text, string: s)
        end
      next hash unless use_stub_slice

      hash.transform_values { |v| stub_slice(**v) }
    end
  end

  def expr(key, value = nil, **values)
    { key => value || values }
  end

  # Round the minority digits, taking into account the number of digits in the integer part.
  # If digit=10 and the integer part has 7 digits, round to the nearest 3 decimal places.
  def fixed_digit_round(number, digit = 10)
    fix = number.to_i.to_s
    decimal_digit = digit - fix.length
    decimal_digit = 0 if decimal_digit.negative?

    number.round(decimal_digit).to_d
  end
end

class Hash
  def &(other)
    merge(other)
  end
end
