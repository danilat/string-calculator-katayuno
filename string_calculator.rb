class StringCalculator
  DEFAULT_SEPARATOR = /[\n,]/
  CUSTOM_SEPARATOR_INIT = "//"
  CUSTOM_SEPARATOR_END = "\n"
  def add(input)
    result = 0
    input_parser(input).split(@separator).each do |value|
      result += value.to_i
    end
    return result
  end

  def input_parser(input)
    @separator = DEFAULT_SEPARATOR
    if custom_separator?(input)
      input_parts = input.split(CUSTOM_SEPARATOR_INIT)
      @separator = input_parts[1].split(CUSTOM_SEPARATOR_END)[0]
      input = input_parts[1].split(CUSTOM_SEPARATOR_END)[1]
    end
    return input
  end

  def custom_separator?(input)
    input_parts = input.split(CUSTOM_SEPARATOR_INIT)
    return input_parts.size > 1
  end
end
