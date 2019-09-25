class Bandpass
  class NoInput < RuntimeError; end
  class NonIntegerInput < RuntimeError; end
  class NegativeIntegerInput < RuntimeError; end

  HIGH_PASS_FREQUENCY = 1000
  LOW_PASS_FREQUENCY = 40

  def filter(input)
    raise NonIntegerInput if non_integer?(input)
    raise NegativeIntegerInput if negative_integer?(input)
    raise NoInput if input.empty?

    input.map do |frequency|
      if frequency < LOW_PASS_FREQUENCY
        LOW_PASS_FREQUENCY
      elsif frequency > HIGH_PASS_FREQUENCY
        HIGH_PASS_FREQUENCY
      else
        frequency
      end
    end
  end

  private

  def negative_integer?(input)
    input.index(&:negative?)
  end

  def non_integer?(input)
    input.index { |value| !value.instance_of? Integer }
  end
end