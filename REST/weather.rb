require 'net/http'
require 'json'
require 'uri'

class Weather
# Define the endpoint
url = URI("https://api.open-meteo.com/v1/forecast?latitude=51.51&longitude=-0.13&current_weather=true")

# Send a GET request
response = Net::HTTP.get(url)

# Parse the JSON response
data = JSON.parse(response)

# Print the current temperature
puts "Current temperature in London: #{data['current_weather']['temperature']}°C"

end
