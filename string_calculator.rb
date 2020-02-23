class StringCalculator
  def add(input)
    result = 0
    numbers_parser = NumbersParser.new(input)
    numbers_parser.number_values.each do |value|
      result += value
    end
    result
  end
end

class NumbersParser
  def initialize(input)
    if CustomValuesSeparator.custom?(input)
      @values_separator = CustomValuesSeparator.new(input)
    else
      @values_separator = DefaultValuesSeparator.new(input)
    end
  end

  def number_values
    @values_separator.values.collect(&:to_i)
  end  
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
