# frozen_string_literal: true

module KobanaPix
  class Configuration
    attr_accessor :url, :api_key
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
