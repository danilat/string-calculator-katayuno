class StringCalculator
  MAX_NUMBER_TO_USE = 1000

  def add(input)
    return 0 if input.empty?
    
    numbers_parser = PositiveNumbersParser.new(input)
    AdderWithoutBigNumbers.new(numbers_parser.number_values, MAX_NUMBER_TO_USE).result
  end
end

class AdderWithoutBigNumbers
  attr_reader :result
  def initialize(numbers, limit)
    @result = numbers.select { |number| number <= limit }
                     .reduce { |sum, number| sum += number }
  end
end

class PositiveNumbersParser
  def initialize(input)
    if CustomValuesSeparator.custom?(input)
      @values_separator = CustomValuesSeparator.new(input)
    else
      @values_separator = DefaultValuesSeparator.new(input)
    end
  end

  def number_values
    @values_separator.values.collect do |value|
      value = value.to_i
      validate_positive_value!(value)

      value
    end
  end

  private def validate_positive_value!(value)
    raise NegativesNotAllowed if value.negative?
  end
end

class NegativesNotAllowed < StandardError
end

class CustomValuesSeparator
  CUSTOM_SEPARATOR_INIT = "//"
  CUSTOM_SEPARATOR_END = "\n"

  def self.custom?(input)
    input.start_with?(CUSTOM_SEPARATOR_INIT) && input.include?(CUSTOM_SEPARATOR_END)
  end

  def initialize(input)
    @separator_and_numbers = input.slice(CUSTOM_SEPARATOR_INIT.size..-1)
  end

  def values
    values_joined.split(separator)
  end

  private def separator
    @separator_and_numbers.split(CUSTOM_SEPARATOR_END)[0]
  end

  private def values_joined
    @separator_and_numbers.split(CUSTOM_SEPARATOR_END)[1]
  end
end

class DefaultValuesSeparator
  DEFAULT_SEPARATION = /[\n,]/

  def initialize(input)
    @input = input
  end

  def values
    @input.split(DEFAULT_SEPARATION)
  end
end
