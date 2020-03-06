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
  def initialize(numbers, limit_number)
    @result = numbers.select { |number| number <= limit_number }
                     .reduce { |sum, number| sum += number }
  end
end

class PositiveNumbersParser
  def initialize(input)
    if ValuesWithCustomSeparators.custom?(input)
      @values_separator = ValuesWithCustomSeparators.new(input)
    else
      @values_separator = ValuesWithDefaultSeparators.new(input)
    end
  end

  def number_values
    @values_separator.run.collect do |value|
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

class ValuesWithCustomSeparators
  CUSTOM_SEPARATOR_INIT = "//"
  CUSTOM_SEPARATOR_END = "\n"

  def self.custom?(input)
    input.start_with?(CUSTOM_SEPARATOR_INIT) && input.include?(CUSTOM_SEPARATOR_END)
  end

  def initialize(input)
    @separator_and_numbers = input.slice(CUSTOM_SEPARATOR_INIT.size..-1)
  end

  def run
    values_joined.split(separator)
  end

  private def separator
    separator = @separator_and_numbers.split(CUSTOM_SEPARATOR_END)[0]
    if multicharacter_separator?(separator)
      separator = separator.slice(1..- 2)
    end
    separator
  end

  private def multicharacter_separator?(separator)
    separator.start_with?("[") && separator.include?("]")
  end

  private def values_joined
    @separator_and_numbers.split(CUSTOM_SEPARATOR_END)[1]
  end
end

class ValuesWithDefaultSeparators
  DEFAULT_SEPARATION = /[\n,]/

  def initialize(input)
    @input = input
  end

  def run
    @input.split(DEFAULT_SEPARATION)
  end
end
