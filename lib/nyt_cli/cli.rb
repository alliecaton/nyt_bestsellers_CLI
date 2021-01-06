
class NytCli::Cli


@@emojis= ["🚨", "📚"]

    ## Kickstarts the CLI 
    def call
        puts "#{@@emojis[1]} Welcome to the New York Times Bestseller List CLI. Within this CLI, you will be able to view the books on the NYT Bestselling Fiction list for a given date starting from 2011, when they moved their Bestsellers publication online. #{@@emojis[1]} \n\n".cyan.bold.center(100)
        puts "Please choose an option by entering a number:"
        puts "[1]  ".green + "Get fiction bestsellers list for a given date"
        puts "[2]  ".green + "Check if a book has ever appeared on a fiction bestsellers list"
        puts "[3]  ".green + "Exit the application\n\n"
        input = gets.chomp.downcase.strip

        case input 
        when "1"
            get_date
        # when "2"
        #     enter_book
        when "3"
            exit! 
        else
            puts "\ #{@@emojis[0]} Please enter the number that corresponds with what you would like to do. #{@@emojis[0]}\n".red
            sleep(1)
            call
        end
    end


    ## Get user date they would like to view 
    def get_date
        puts "The first published online NYT Bestsellers list was on 2011-02-13.\nTo get started, please enter a date (YYYY-MM-DD):".yellow
        date = gets.chomp
        if valid_time?(date)
            create_api_and_book(date)
        end
    end

    # def enter_book
    #     puts "To get started, please enter the name of a book:\n".yellow
    #     title = gets.chomp.strip.upcase
    #     NytCli::Scraper.new(title)
    #     title
    #     # create_new_from_history
    # end

    # def create_new_from_history
    #     title = enter_book
    #     NytCli::Book.find_by_title(title)
    #     binding.pry
    # end

    def valid_time?(date)
        Date.valid_date? *"#{Date.strptime(date,"%Y-%m-%d")}".split('-').map(&:to_i) 
        rescue 
            puts "\n#{@@emojis[0]} Oops! That input is invalid. Please input a valid date using YYYY-MM-DD #{@@emojis[0]}\n".red
            sleep(1)
            get_date
    end

    ## Checks to make sure the date is an actual date, and that it fits the criteria for the API call (format and start date)
    # def valid?(date)
    #     y = date.split("-")[0].to_i
    #     m = date.split("-")[1].to_i
    #     d = date.split("-")[2].to_i
    #     new_date = Time.new(y, m, d)
    #     nyt_start_date = Time.new(2011, 2, 13)
    #     valid_format = date.match(/\d{4}-\d{2}-\d{2}/)




        #valid_time = DateTime.parse date
        # valid_time = Date.strptime(date, '%Y-%m-%d') rescue false
        #date == 'never'
        # if valid_format && new_date <= Time.now && new_date >= nyt_start_date && (Date.valid_date?(y,m,d) rescue false)
        #     true
        #     binding.pry
        # else
        #     puts "\n#{@@emojis[0]} Oops! That input is invalid. Please input a valid date using YYYY-MM-DD #{@@emojis[0]}\n".red
        #     sleep(1)
        #     get_date
        # end

    # end
    


    ## creates the new API call, initialized with validated input date. Once called, asks user for input
    def create_api_and_book(date)
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
        show_book(num)
        num
    end

    ## List all books
    def list_books
        NytCli::Book.all.each.with_index(1) do |book,index|
            puts "[#{index}]  ".green + "#{book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} - #{book.author}".white
        end
    end

    ## Shows attributes of individaul book after selected by user, saves the user choice into class array @@all_selected for easy access
    def show_book(num)
        chosen_book = NytCli::Book.all[num - 1]
        NytCli::Book.all_viewed << chosen_book
        puts "Title: ".blue + "#{chosen_book.title.downcase.split(/ |\_|\-/).map(&:capitalize).join(" ")} \n" + "Author: ".blue + "#{chosen_book.author}" + " \nRank: ".blue + "#{chosen_book.rank}" + " \nDescription: ".blue + "#{chosen_book.description}\n\n"
        indiv_book_menu
        chosen_book
    end

    ## Menu choices for individual book 
    def indiv_book_menu
        puts "What would you like to do? Please input a number\n\n"
        puts "[1]  ".green + "Select another book from the list"
        puts "[2]  ".green + "Buy book"
        puts "[3]  ".green + "Exit the application\n\n"
        input = gets.chomp.downcase.strip

        case input 
        when "1"
            ask
        when "2"
            buy_book
        when "3"
            exit! 
        else
            puts "\ #{@@emojis[0]} Please enter the number that corresponds with what you would like to do. #{@@emojis[0]}\n".red
            sleep(1)
            indiv_book_menu
        end
    end

    def buy_book
        current_book = NytCli::Book.all_viewed.last
        current_book.buy_links.each do |shop|
            if shop["url"].include? "barnes"
                Launchy.open(shop["url"])
            end 
        end 
    end


end