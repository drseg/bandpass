require_relative '../lib/bandpass'

describe Bandpass do
  context 'given invalid input' do
    context 'given an empty array' do
      it 'raises a no input error' do
        expect { subject.filter([]) }.to raise_error Bandpass::NoInput
      end
    end

    context 'given nil' do
      it 'raises a no input error' do
        expect { subject.filter(nil) }.to raise_error Bandpass::NoInput
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
    context 'given custom high pass of 500' do
      it 'adjusts high pass frequencies to 500' do
        subject.high_pass_frequency = 500
        expect(subject.filter([499, 500, 501, 502])).to eq [499, 500, 500, 500]
      end
    end

    context 'given default high pass of 1000' do
      it 'adjusts high pass frequencies to 1000' do
        expect(subject.filter([999, 1000, 1001, 1002])).to eq [999, 1000, 1000, 1000]
      end

      context 'given a custom low pass of 100' do
        it 'adjusts low pass frequencies to 100' do
          subject.low_pass_frequency = 100
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