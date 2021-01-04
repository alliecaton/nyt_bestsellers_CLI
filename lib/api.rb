require 'pry'
require 'open-uri'
require 'net/http'
require 'json'

class Api

    def initialize(date)
        @date = date 
    end 

    def get
        url = "https://api.nytimes.com/svc/books/v3/lists/#{@date}/combined-print-and-e-book-fiction.json?api-key=BVgaZJuV9zrt2JKrUhHQFG5gZiAKvGkf"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        response_hash = JSON.parse(response.body)
        nyt_data = response_hash["results"]["books"]
    end

end 


# api = Api.new("2020-10-05")
# api.get

# binding.pry

