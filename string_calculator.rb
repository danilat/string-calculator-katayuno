class StringCalculator
  MAX_NUMBER_TO_USE = 1000
  CUSTOM_SEPARATOR_INIT = "//"
  CUSTOM_SEPARATOR_END = "\n"

  def initialize
    
  end

  def add(input)
    return 0 if input.empty?
    
    numbers_parser = PositiveNumbersParser.new(values_separator_for(input))
    AdderWithoutBigNumbers.new(numbers_parser.number_values, MAX_NUMBER_TO_USE).result
  end

  def values_separator_for(input)
    if custom_separators?(input)
      separator_configuration = CustomSeparatorConfiguration.new(CUSTOM_SEPARATOR_INIT, CUSTOM_SEPARATOR_END)
      ValuesWithCustomSeparator.new(input, separator_configuration)
    else
      ValuesWithDefaultSeparator.new(input)
    end
  end

  private def custom_separators?(input)
    input.start_with?(CUSTOM_SEPARATOR_INIT) && input.include?(CUSTOM_SEPARATOR_END)
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
  def initialize(values_separator)
    @values_separator = values_separator
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

class ValuesWithCustomSeparator
  MULTICHARACTER_SEPARATOR_INIT = "["
  MULTICHARACTER_SEPARATOR_END = "]"

  def initialize(input, separator_configuration)
    custom_separator_and_values = input.delete_prefix(separator_configuration.start)
    @custom_separator_and_values_parts = custom_separator_and_values.split(separator_configuration.end)
  end

  def run
    @custom_separator = @custom_separator_and_values_parts[0]
    @values_joined = @custom_separator_and_values_parts[1]
    separator = clean_multicharacter_separators(@custom_separator)
    @values_joined.split(separator)
  end

  private def custom_separator_and_values_parts
    custom_separator_and_values = @input.delete_prefix(@separator_configuration.start)
    custom_separator_and_values.split(@separator_configuration.end)
  end

  private def clean_multicharacter_separators(separator)
    separator.delete_prefix(MULTICHARACTER_SEPARATOR_INIT).delete_suffix(MULTICHARACTER_SEPARATOR_END)
  end
end

class CustomSeparatorConfiguration
  attr_reader :start, :end
  def initialize(start_characters, end_characters)
    @start = start_characters
    @end = end_characters
  end
end

class ArbitraryLengthSeparatorConfiguration
  attr_reader :start, :end
  def initialize(start_characters, end_characters)
    @start = start_characters
    @end = end_characters
  end
end

class ValuesWithDefaultSeparator
  DEFAULT_SEPARATION = /[\n,]/

  def initialize(input)
    @input = input
  end

  def run
    @input.split(DEFAULT_SEPARATION)
  end
end
