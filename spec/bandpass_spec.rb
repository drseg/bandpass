require_relative '../lib/bandpass'

describe Bandpass do
  context 'given an input of 20, 30, 40, 100, 500, 1000, 2000' do
    it 'outputs 40, 40, 40, 100, 500, 1000, 1000' do
      input = [20, 30, 40, 100, 500, 1000, 2000]
      expected_output = [40, 40, 40, 100, 500, 1000, 1000]
      expect(subject.filter(input)).to eq expected_output
    end
  end
end