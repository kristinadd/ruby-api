# Standard Ruby library modules are pre-installed Ruby code packages that come built-in with Ruby itself. 
# You don’t need to install anything extra — you just use require to load them into your script.
# no gem install needed

require 'net/http'
require 'json'
require 'uri'

class Weather
# Define the endpoint
url = URI("https://api.open-meteo.com/v1/forecast?latitude=51.51&longitude=-0.13&past_days=1&daily=temperature_2m_max")

# forecast_days default to 7
# So you are getting:
# 1 day in the past (yesterday)
# 7 days into the future

# Send a GET request
response = Net::HTTP.get(url)

# Parse the JSON response
data = JSON.parse(response)

# turn strings into symbols
# data = JSON.parse(response, symbolize_names: true)


puts data

# puts data[:current_weather][:temperature]
# puts data["current_weather"]["temperature"]
# puts data["current_weather"]["time"]
end
