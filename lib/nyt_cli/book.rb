class NytCli::Book

    attr_accessor :title, :author, :rank, :description, :buy_links, :ranks_history

    @@all = [] ## All book instances
    @@user_saved_books = [] ## All book instances that user saves within their session
    @@all_selected = [] ## All book instances that the user has viewed

    ## Initializes book with only specified keys of a hash-- possibly add where to buy later
    def initialize(hash)
        @title = title
        @author = author
        @description = description
        hash.each do |key,value| 
            if key == "title" 
                self.send(("#{key}="), value)
            elsif key == "rank"
                self.send(("#{key}="), value)
            elsif key == "author"
                self.send(("#{key}="), value)
            elsif key == "description"
                self.send(("#{key}="), value)
            elsif key == "buy_links"
                self.send(("#{key}="), value)
            elsif key == "ranks_history"
                self.send(("#{key}="), value)
            end
        end
        save
    end 

    def save 
        @@all << self
    end

    def self.all
        @@all
    end
    
    def self.all_viewed
        @@all_selected
    end

    def self.user_save
        @@user_saved_books << self
        binding.pry
    end

    def self.view_saved
        @@user_saved_books
    end

    def self.find_by_title(title)
        @@all.find do |book|
            if book.title == title
                book
            end
        end
    end

    def reset!
        @@all.clear
    end

end