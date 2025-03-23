require 'net/http'
require 'json'
require 'uri'

class Countries
  # Define the GraphQL endpoint
  url = URI("https://countries.trevorblades.com/")

  # Define the GraphQL query
  query = {
    query: <<~GRAPHQL
      {
        country(code: "GB") {
          name
          capital
          currency
        }
      }
    GRAPHQL
  }

  # Send POST request with the query
  response = Net::HTTP.post(
    url,
    query.to_json,
    "Content-Type" => "application/json"
  )

  # Parse the response JSON
  data = JSON.parse(response.body)

  # Print the data
  puts JSON.pretty_generate(data)

end