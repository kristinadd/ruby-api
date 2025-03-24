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
        country(code: "BG") {
          awsRegion
          capital
          code
          continent {
            name
          }
          currency
          emoji
          languages {
            name
          }
          name
          phone
          subdivisions {
            name
            emoji
            code
          }
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

  puts data["data"].keys.first.class # confirm the type of the key

  # query ramdom field from the ruby hash

  puts data["data"]["country"]["name"]


end