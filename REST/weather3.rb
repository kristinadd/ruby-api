require 'net/http'
require 'json'
require 'uri'

class WeatherFetcher
  BASE_URL = "https://api.open-meteo.com/v1/forecast"

  def initialize(latitude:, longitude:, timezone: "auto")
    @latitude = latitude
    @longitude = longitude
    @timezone = timezone
  end

  def fetch(past_days: nil, forecast_days: nil, hourly: nil, daily: nil)
    uri = build_uri(
      past_days: past_days,
      forecast_days: forecast_days,
      hourly: hourly,
      daily: daily
    )

    response = Net::HTTP.get_response(uri)

    unless response.is_a?(Net::HTTPSuccess)
      puts "❌ Request failed: #{response.code} #{response.message}"
      return
    end

    data = JSON.parse(response.body)
    print_summary(data, hourly: hourly, daily: daily)
  end

  private

  def build_uri(past_days:, forecast_days:, hourly:, daily:)
    params = {
      latitude: @latitude,
      longitude: @longitude,
      timezone: @timezone
    }
    params[:past_days] = past_days if past_days
    params[:forecast_days] = forecast_days if forecast_days
    params[:hourly] = hourly.join(",") if hourly&.any?
    params[:daily] = daily.join(",") if daily&.any?

    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(params)
    uri
  end

  def print_summary(data, hourly:, daily:)
    puts "\n📍 Weather data for lat=#{@latitude}, lon=#{@longitude}"

    if daily && data["daily"]
      puts "\n📅 Daily:"
      times = data["daily"]["time"]
      daily.each do |variable|
        values = data["daily"][variable]
        puts "\n#{variable}:\n"
        times.each_with_index do |time, i|
          puts "  #{time}: #{values[i]}"
        end
      end
    end

    if hourly && data["hourly"]
      puts "\n🕒 Hourly:"
      times = data["hourly"]["time"]
      hourly.each do |variable|
        values = data["hourly"][variable]
        puts "\n#{variable}:\n"
        times.each_with_index do |time, i|
          puts "  #{time}: #{values[i]}"
        end
      end
    end
  end
end

# 🔧 Example usage
weather = WeatherFetcher.new(latitude: 51.51, longitude: -0.13)

weather.fetch(
  past_days: 1,
  forecast_days: 3,
  daily: ["temperature_2m_max", "temperature_2m_min"],
  hourly: ["temperature_2m"]
)
