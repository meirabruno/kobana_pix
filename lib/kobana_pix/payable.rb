# frozen_string_literal: true

module KobanaPix
  class Payable
    def self.charge(body)
      headers = { 'Accept' => 'application/json',
                  'Content-Type' => 'application/json',
                  'Authorization' => "Bearer #{KobanaPix.configuration.api_key}" }

      response = HTTParty.post(KobanaPix.configuration.url, headers: headers, body: body)

      JSON.parse(response.body)
    end
  end
end
