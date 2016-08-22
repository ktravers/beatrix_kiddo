module Google
  class GeocodeClient
    attr_reader :conn, :access_token
    attr_accessor :error

    BASE_URL = 'https://maps.googleapis.com/maps/api/geocode/json?'

    def initialize(access_token: nil)
      @access_token = access_token || ENV['GOOGLE_GEOCODE_TOKEN']

      @conn = Faraday.new do |f|
        f.request :url_encoded
        f.adapter Faraday.default_adapter
      end
    end

    def geocode(location_string)
      as_new_request do
        get(BASE_URL, { address: location_string })
      end
    end

    def success?
      !error?
    end

    def error?
      !!error
    end

    private

    def as_new_request
      self.error = nil
      response = yield

      unless response['status'] == 'OK'
        self.error = response['error_message'] || response['status']
      end

      response
    end

    def get(url, params={})
      http_request(:get, url, params)
    end

    def http_request(method, url, params={})
      response = conn.send(method) do |req|
        req.url url
        req.params[:key] = access_token

        params.each do |param, val|
          req.params[param] = val
        end
      end

      begin
        JSON.parse(response.body)
      rescue => e
        self.error = e.message
        {}
      end
    end

  end
end
