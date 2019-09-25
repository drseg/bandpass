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
        expect { subject.filter([])}.to raise_error Bandpass::NoInput
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
    context 'given default high pass of 1000' do
      it 'adjusts high pass frequencies to 1000' do
        expect(subject.filter([1000, 1001, 2000, 3000])).to eq [1000, 1000, 1000, 1000]
      end

      context 'given default low pass of 40' do
        it 'adjusts low pass frequencies to 40' do
          expect(subject.filter([30])).to eq [40]
        end
      end
    end
  end

  context 'given an input of 20, 30, 40, 100, 500, 1000, 2000' do
    xit 'outputs 40, 40, 40, 100, 500, 1000, 1000' do
      input = [20, 30, 40, 100, 500, 1000, 2000]
      expected_output = [40, 40, 40, 100, 500, 1000, 1000]
      expect(subject.filter(input)).to eq expected_output
    end
  end
end