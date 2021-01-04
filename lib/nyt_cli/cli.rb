class NytCli::Cli

    def call
        date = get_date
        api= NytCli::Api.new(date)
        api.create_book
        list_books
    end

    def get_date
        puts "Please enter a date (YYYY-MM-DD):"
        date = gets.chomp
        date
    end

    def list_books
        NytCli::Book.all
    end

    
    # def call
    #     puts "Welcome! Enter a date (YYYY-MM-DD)"
    #     gets_date
    # end

    # def get_date
    #     input = gets.chomp
    # end 

    # def list_books
    #     puts "book"
    #     @books = NytCli::Book.book
    #     @books
    # end

    # def list_authors
    # end

    # def goodbye
    #     puts "bye!"
    # end

end