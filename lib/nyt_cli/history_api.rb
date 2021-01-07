class NytCli::HistoryApi

    def initialize(title, offset=0, url=https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?#offset=#{@offset}&api-key=BVgaZJuV9zrt2JKrUhHQFG5gZiAKvGkf)
        @title = title
        @offset = offset
        get_history
        # create_book_from_history
        get_history
    end 

    def get_history(url)
        url = "https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json?#offset=#{@offset}&api-key=BVgaZJuV9zrt2JKrUhHQFG5gZiAKvGkf"
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        response_hash = JSON.parse(response.body)
       response_hash["results"]
        get_pagination(url)
    end

    def get_pagination(path)
        results = []
        binding.pry
        while path < path.count
            @offset += 20
            url
            results << get_history
            binding.pry
        end
    end


    def create_book_from_history
        current_page = 1
        per_page = 20
        total_results = response_hash["num_results"]
        get_history.each do |book|
            if book["title"].include?(@title)
                new_book = NytCli::Book.new(book)
                true
            end
        end
    end

end