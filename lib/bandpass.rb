class Bandpass
  class NoInput < RuntimeError; end
  class NonIntegerInput < RuntimeError; end
  class NegativeIntegerInput < RuntimeError; end
  class InvalidPassFrequency < RuntimeError; end

  DEFAULT_HIGH_PASS_FREQUENCY = 1000
  DEFAULT_LOW_PASS_FREQUENCY  = 40

  def initialize
    @high_pass = DEFAULT_HIGH_PASS_FREQUENCY
    @low_pass  = DEFAULT_LOW_PASS_FREQUENCY
  end

  def filter(freqs)
    validate(freqs)

    high_pass_filter(low_pass_filter(freqs))
  end

  def low_pass=(freq)
    validate_low_pass(freq)

    @low_pass = freq
  end

  def high_pass=(freq)
    validate_high_pass(freq)

    @high_pass = freq
  end

  private

  def high_pass_filter(input)
    input.map { |freq| freq < @low_pass ? @low_pass : freq }
  end

  def low_pass_filter(input)
    input.map { |freq| freq > @high_pass ? @high_pass : freq }
  end

  def validate_low_pass(freq)
    raise InvalidPassFrequency, freq if valid_high_pass?(freq)
  end

  def valid_high_pass?(freq)
    freq >= @high_pass || freq < 1
  end

  def validate_high_pass(freq)
    raise InvalidPassFrequency, freq if valid_low_pass?(freq)
  end

  def valid_low_pass?(freq)
    freq <= @low_pass
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