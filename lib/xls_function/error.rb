module XlsFunction
  # Default Error
  class EvaluationError < StandardError
  end

  class ErrorValue < String
    attr_reader :error_info

    def initialize(string = '', error_info = '')
      @error_info = error_info
      super(string)
    end

    def to_s
      super + error_info
    end

    def error?
      true
    end

    class << self
      # @return #VALUE!
      def value!(error_info = '')
        new(ERROR_VALUE, error_info)
      end

      # @return #NUM!
      def num!(error_info = '')
        new(ERROR_NUM, error_info)
      end

      # @return #N/A
      def na(error_info = '')
        new(ERROR_NA, error_info)
      end
    end
  end

  ERROR_VALUE = '#VALUE!'.freeze
  ERROR_NUM = '#NUM!'.freeze
  ERROR_NA = '#N/A'.freeze

  ERRORS = [
    ERROR_VALUE,
    ERROR_NUM,
    ERROR_NA
  ].freeze
end
