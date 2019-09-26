require_relative '../lib/bandpass'

describe Bandpass do
  context 'given invalid input' do
    def expect_no_input_error
      expect { yield }.to raise_error Bandpass::NoInput
    end

    context 'given an empty array' do
      it 'raises a no input error' do
        expect_no_input_error { subject.filter([]) }
      end
    end

    context 'given nil' do
      it 'raises a no input error' do
        expect_no_input_error { subject.filter(nil) }
      end
    end

    context 'given array containing non-integers' do
      it 'raises a non integer input error' do
        expect { subject.filter([1, 2, 3, 'x']) }.to raise_error Bandpass::NonIntegerInput
      end
    end

    context 'given array containing negative integers' do
      it 'raises a negative integer input error' do
        expect { subject.filter([-1, 1, 2]) }.to raise_error Bandpass::NegativeIntegerInput
      end
    end
  end

  context 'given valid input' do
    def expect_invalid_pass_frequency
      expect { yield }.to raise_error Bandpass::InvalidPassFrequency
    end

    context 'given custom high pass of 500' do
      before :each do
        subject.high_pass = 500
      end

      it 'cannot set low pass equal to or above high pass' do
        expect_invalid_pass_frequency { subject.low_pass = 500 }
      end

      it 'cannot set low pass to less than 1' do
        expect_invalid_pass_frequency { subject.low_pass = 0 }
      end

      it 'adjusts high pass frequencies to 500' do
        expect(subject.filter([499, 500, 501, 502])).to eq [499, 500, 500, 500]
      end
    end

    context 'given default high pass of 1000' do
      it 'adjusts high pass frequencies to 1000' do
        expect(subject.filter([999, 1000, 1001, 1002])).to eq [999, 1000, 1000, 1000]
      end

      context 'given a custom low pass of 100' do
        before :each do
          subject.low_pass = 100
        end

        it 'cannot set high pass equal to or below low pass' do
          expect_invalid_pass_frequency { subject.high_pass = 100 }
        end

        it 'adjusts low pass frequencies to 100' do
          expect(subject.filter([98, 99, 100, 101])).to eq [100, 100, 100, 101]
        end
      end

      context 'given default low pass of 40' do
        it 'adjusts low pass frequencies to 40' do
          expect(subject.filter([30, 39, 40, 41])).to eq [40, 40, 40, 41]
        end
      end
    end
  end

  context 'given an input of 20, 30, 40, 100, 500, 1000, 2000' do
    it 'outputs 40, 40, 40, 100, 500, 1000, 1000' do
      input = [20, 30, 40, 100, 500, 1000, 2000]
      expected_output = [40, 40, 40, 100, 500, 1000, 1000]
      expect(subject.filter(input)).to eq expected_output
    end
  end
end