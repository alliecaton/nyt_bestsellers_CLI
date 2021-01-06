class NytCli::Scraper

    # def initialize(title)
    #     @title = title
    #     get_history
    #     create_book_from_history
    # end 

    # def get_history
    #     url = "https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?api-key=BVgaZJuV9zrt2JKrUhHQFG5gZiAKvGkf"
    #     uri = URI.parse(url)
    #     response = Net::HTTP.get_response(uri)
    #     response_hash = JSON.parse(response.body)
    #     response_hash["results"]
    # end

    # def create_book_from_history
    #     get_history.each do |book|
    #         if book["title"].include?(@title)
    #             new_book = NytCli::Book.new(book)
    #         else 
    #             nil
    #             binding.pry
    #         end
    #     end
    # end


end