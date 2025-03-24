require 'net/http'
require 'json'
require 'uri'

require 'pp'

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
  puts data["data"]["country"]["name"] # query ramdom field from the ruby hash
  pp data
  puts data



  # FILTERS
  query2 = {
    query: <<~GRAPHQL
      {
        countries(filter: {continent: {eq: "EU"}}) {
          name
          code
          emoji
        }
    }
    GRAPHQL
  }

  response2 = Net::HTTP.post(
    url,
    query2.to_json,
    "Content-Type" => "application/json"
  )

  data2 = JSON.parse(response2.body)
  puts JSON.pretty_generate(data2)


  query3 = {
    query: <<~GRAPHQL
      {
    countries(filter: {continent: {in: ["EU", "AS"]}}) {
      name
      code
      emoji
      }
    }
    GRAPHQL
  }

  response3 = Net::HTTP.post(
    url,
    query3.to_json,
    "Content-Type" => "application/json")

  data3 = JSON.parse(response3.body)
  puts JSON.pretty_generate(data3)

end