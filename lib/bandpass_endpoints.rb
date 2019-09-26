require 'sinatra'
require_relative '../lib/bandpass'

class BandpassEndpoints < Sinatra::Base
  post '/filter' do
    FilterEndpoint.new(params).filter
  end
end

class FilterEndpoint
  def initialize(params)
    @params = params
    @bandpass = Bandpass.new
    @bandpass.high_pass_frequency = high_pass
    @bandpass.low_pass_frequency = low_pass
  end

  def filter
    filtered_frequencies
  end

  private

  def filtered_frequencies
    { 'frequencies': @bandpass.filter(frequencies) }.to_json
  end

  def frequencies
    @params['frequencies'].tr(' ', '').split(',').map(&:to_i)
  end

  def high_pass
    @params['upper_limit'].to_i
  end

  def low_pass
    @params['lower_limit'].to_i
  end
end