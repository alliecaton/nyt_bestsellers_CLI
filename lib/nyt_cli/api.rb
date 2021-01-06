

class NytCli::Api

    attr_accessor :date

    def initialize(date)
        @date = date
        create_book
    end

    ## Calls on the API with the date initialized
    def get
        url = "https://api.nytimes.com/svc/books/v3/lists/#{@date}/combined-print-and-e-book-fiction.json?api-key=BVgaZJuV9zrt2JKrUhHQFG5gZiAKvGkf"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        response_hash = JSON.parse(response.body)
        response_hash["results"]["books"]
    rescue 
        "Invalid date"
    end


    ## Creates a book using a hash of relevant attributes
    def create_book
        get.each do |book|
            new_book = NytCli::Book.new(book)
        end
    end

end 



