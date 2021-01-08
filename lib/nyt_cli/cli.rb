class NytCli::Cli


@@emojis= ["🚨", "📚", "👋"]

    ## Kickstarts the CLI 
    def call
        puts "\n\n#{@@emojis[1]} Welcome to the New York Times Bestseller List CLI. Within this CLI, you will be able to view the books on the NYT Bestselling Fiction list for a given date. #{@@emojis[1]} \n\n".cyan.bold.center(100)
        ask_input
    end

    ## Asks for initial user input
    def ask_input 
        puts "\n\nPlease choose an option by entering a number:\n\n"
        puts "[1]  ".green + "Get fiction bestsellers list for a given date"
        puts "[2]  ".green + "View your saved books"
        puts "[3]  ".green + "Exit the application\n\n"
        input = gets.chomp.downcase.strip

        case input 
        when "1"
            get_date
        when "2"
            puts "\n"
            view_saved
        when "3"
            exit! 
        else
            puts "\n#{@@emojis[0]} Please enter the number that corresponds with what you would like to do. #{@@emojis[0]}\n".red
            sleep(1)
            ask_input
        end
    end

    ## Get user date they would like to view 
    def get_date
        puts "\nThe first published online NYT Bestsellers list was on 2011-02-13.\nTo get started, please enter a date (YYYY-MM-DD):\n".yellow
        date = gets.chomp
        if valid_date?(date) && valid_timeframe?(date)
            create_api_and_book(date)
        end
    end

    ## Checks if date is real and in the correct format
    def valid_date?(date)
        Date.valid_date? *"#{Date.strptime(date,"%Y-%m-%d")}".split('-').map(&:to_i) 
        rescue 
            puts "\n#{@@emojis[0]} Oops! That input is invalid. Please input a valid date using YYYY-MM-DD #{@@emojis[0]}\n".red
            sleep(1)
            get_date
    end

    ## Checks to make sure the date is between the NYT start date, and the current date
    def valid_timeframe?(date)
        new_date = Time.new(date.split("-")[0].to_i, date.split("-")[1].to_i, date.split("-")[2].to_i)
        nyt_start_date = Time.new(2011, 2, 13)
        if new_date <= Time.now && new_date >= nyt_start_date
            true
        else
            puts "\n#{@@emojis[0]} Oops! That input is invalid. Make sure your date falls between now and 2011-02-13 #{@@emojis[0]}\n".red
            sleep(1)
            get_date
        end
    end

    ## creates the new API call, initialized with validated input date. Once called, asks user for input
    def create_api_and_book(date)
        NytCli::Book.reset!
        api= NytCli::Api.new(date)
        ask
    end

    ## Asks user what they want to do 
    def ask
        puts "\n\nHere are the best selling books for that date. Choose a book to view more information.\n  ".yellow
        list_books
        puts "\nPlease enter the number that corresponds to the book you would like to view\n".yellow
        num = gets.chomp.to_i
        puts "\n"
        if num.between?(1,NytCli::Book.all.count)
            show_book(num)
        else
            puts "#{@@emojis[0]} Please input a valid number #{@@emojis[0]}"
            sleep(1)
            ask
        end
    end

    ## List all books
    def list_books
        NytCli::Book.all.each.with_index(1) do |book,index|
            puts "[#{index}]  ".green + "#{book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{book.author}".white
        end
    end

    ## View saved collection for session if your collection count is greater than 0
    def view_saved
        if  NytCli::Book.collection.count != 0
             NytCli::Book.collection.uniq.each.with_index(1) do |book,index|
                puts "[#{index}]  ".green + "#{book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{book.author}".white
             end
            collection_options
        else 
            puts "\n#{@@emojis[0]} You have no saved books #{@@emojis[0]}\n\n"
            sleep(1)
            ask_input
        end
    end

    def collection_options
        puts "\n\nIf you would like more information on any of your saved books, input the number associated with the book you would like to view"
        num = gets.chomp.to_i
        if num.between?(1,NytCli::Book.collection.count)
            show_from_collection(num)
        end
    end

    ## Show individual chosen book from collection 
    def show_from_collection(num)
        chosen_book = NytCli::Book.collection[num - 1]
        NytCli::Book.all_viewed << chosen_book
        puts "Title: ".blue + "#{chosen_book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} \n" + "Author: ".blue + "#{chosen_book.author}" + " \nRank: ".blue + "#{chosen_book.rank}" + " \nDescription: ".blue + "#{chosen_book.description}\n\n"
        from_collection_menu
    end 

    def from_collection_menu
        puts "What would you like to do? Please input a number\n\n"
        puts "[1]  ".green + "Return to your collection"
        puts "[2]  ".green + "Buy book"
        puts "[3]  ".green + "Return to main menu"
        puts "[4]  ".green + "Exit the application\n\n"
        input = gets.chomp.downcase.strip

        case input 
        when "1"
            view_saved
        when "2"
            buy_book(NytCli::Book.all_viewed.last.title)
        when "3"
            ask_input
        when "4"
            puts "Goodbye! #{@@emojis[2]}"
            sleep(1)
            exit! 
        else
            puts "\n #{@@emojis[0]} Please enter the number that corresponds with what you would like to do. #{@@emojis[0]}\n".red
            sleep(1)
            from_collection_menu
        end
    end

    ## Shows attributes of individaul book after selected by user, saves the user choice into class array @@all_selected for easy access
    def show_book(num)
        chosen_book = NytCli::Book.all[num - 1]
        NytCli::Book.all_viewed << chosen_book
        puts "Title: ".blue + "#{chosen_book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} \n" + "Author: ".blue + "#{chosen_book.author}" + " \nRank: ".blue + "#{chosen_book.rank}" + " \nDescription: ".blue + "#{chosen_book.description}\n\n"
        indiv_book_menu
    end

    ## Menu choices for individual book 
    def indiv_book_menu
        puts "What would you like to do? Please input a number\n\n"
        puts "[1]  ".green + "Select another book from the list"
        puts "[2]  ".green + "Buy book"
        puts "[3]  ".green + "Add book to session collection"
        puts "[4]  ".green + "Return to main menu"
        puts "[5]  ".green + "Exit the application\n\n"
        input = gets.chomp.downcase.strip

        case input 
        when "1"
            self.ask
        when "2"
            buy_book(NytCli::Book.all_viewed.last.title)
        when "3"
            add_to_collection
        when "4"
            ask_input
        when "5"
            puts "Goodbye! #{@@emojis[2]}"
            sleep(1)
            exit! 
        else
            puts "\ #{@@emojis[0]} Please enter the number that corresponds with what you would like to do. #{@@emojis[0]}\n".red
            sleep(1)
            indiv_book_menu
        end
    end

    ## Links out to a B&N link for selected book 
    def buy_book(title)
        # current_book = NytCli::Book.all_viewed.last
        current_book = NytCli::Book.find_by_title (title)
        current_book.buy_links.each do |shop|
            if shop["url"].include? "barnes"
                Launchy.open(shop["url"])
                self.ask_input
            end 
        end 
    end

    ## Adds book to collection for the session 
    def add_to_collection
        NytCli::Book.collection << NytCli::Book.all_viewed.last
        puts "\nYou've added " + "#{NytCli::Book.all_viewed.last.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} ".blue + "to your saved collection for the session.\n\n"
        sleep(1)
        self.ask
    end


end