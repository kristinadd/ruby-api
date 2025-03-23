require 'net/http'
require 'json'
require 'uri'

class Weather
  def self.fetch_weather(
    latitude:, 
    longitude:, 
    past_days: nil, 
    forecast_days: nil, 
    daily: nil, 
    hourly: nil, 
    timezone: "Europe/London"
    )

    # Base URL
    base_url = "https://api.open-meteo.com/v1/forecast"

    # Build query parameters as a hash
    params = {
      latitude: latitude,
      longitude: longitude,
      timezone: timezone
    }

    # Only add optional params if they are given
    params[:past_days] = past_days if past_days
    params[:forecast_days] = forecast_days if forecast_days
    params[:daily] = daily if daily
    params[:hourly] = hourly if hourly

    # Build the full URL with query params
    uri = URI(base_url) # --> this becomes # <URI::HTTPS https://api.open-meteo.com/v1/forecast> --> it creates the uri object
    uri.query = URI.encode_www_form(params) # --> it constructs the url with the provided params


    # Make the request
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    # Output (for testing)
    puts JSON.pretty_generate(data)
  end
end

# 🔧 Example usage:
Weather.fetch_weather(
  latitude: 51.51,
  longitude: -0.13,
  past_days: 1,
  forecast_days: 0,
  daily: "temperature_2m_max"
)
