require 'rack/test'
require_relative '../lib/bandpass_endpoints'

ENV['APP_ENV'] = 'test'

describe 'Bandpass Endpoint' do
  include Rack::Test::Methods

  def app
    BandpassEndpoints
  end

  describe '/filter' do
    context 'given frequencies 80, 90, 100, 110, 120' do
      context 'given lower limit of 90' do
        context 'given upper limit of 110' do
          it 'returns a JSON object with [90, 90, 100, 110, 110]' do
            body = { 'frequencies': '80, 90, 100, 110, 120',
                     'lower_limit': '90',
                     'upper_limit': '110' }
            post('/filter', body)

            filtered_output = { 'frequencies': [90, 90, 100, 110, 110] }.to_json
            expect(last_response.body).to eq filtered_output
          end
        end
      end
    end
  end
end