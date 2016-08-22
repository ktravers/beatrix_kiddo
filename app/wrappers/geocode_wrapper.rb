class GeocodeWrapper
  attr_reader :client

  def initialize(options={})
    @client = Google::GeocodeClient.new
  end

  def get_coords_from_location(location)
    response = client.geocode(location)

    response['results'].first['geometry']['location'] if response['status'] == 'OK'
  end
end
