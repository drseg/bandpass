class Bandpass
  class NoInput < RuntimeError; end
  class NonIntegerInput < RuntimeError; end
  class NegativeIntegerInput < RuntimeError; end
  class InvalidPassFrequency < RuntimeError; end

  DEFAULT_HIGH_PASS_FREQUENCY = 1000
  DEFAULT_LOW_PASS_FREQUENCY  = 40

  def initialize
    @high_pass_frequency = DEFAULT_HIGH_PASS_FREQUENCY
    @low_pass_frequency = DEFAULT_LOW_PASS_FREQUENCY
  end

  def filter(input)
    validate(input)

    input.map do |frequency|
      if frequency < @low_pass_frequency
        @low_pass_frequency
      elsif frequency > @high_pass_frequency
        @high_pass_frequency
      else
        frequency
      end
    end
  end

  def low_pass=(frequency)
    validate_low_pass(frequency)

    @low_pass_frequency = frequency
  end

  def high_pass=(frequency)
    validate_high_pass(frequency)

    @high_pass_frequency = frequency
  end

  private

  def validate_low_pass(frequency)
    raise InvalidPassFrequency, frequency if frequency >= @high_pass_frequency || frequency < 1
  end

  def validate_high_pass(frequency)
    raise InvalidPassFrequency, frequency if frequency <= @low_pass_frequency
  end

  def validate(input)
    raise NoInput, input if input.nil? || input.empty?
    raise NonIntegerInput, input if non_integer?(input)
    raise NegativeIntegerInput, input if negative_integer?(input)
  end

  def negative_integer?(input)
    input.index(&:negative?)
  end

  def non_integer?(input)
    input.index { |value| !value.instance_of? Integer }
  end
end