class Bandpass
  class NoInput < RuntimeError; end
  class NonIntegerInput < RuntimeError; end
  class NegativeIntegerInput < RuntimeError; end

  attr_writer :high_pass_frequency, :low_pass_frequency

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

  private

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