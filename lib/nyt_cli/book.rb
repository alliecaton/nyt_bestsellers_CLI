class NytCli::Book

    attr_accessor :title, :author, :rank, :description, :buy_links, :ranks_history

    @@all = [] ## All book instances
    @@all_selected = [] ## All book instances that the user has viewed
    @@saved = [] ## Books user has saved to their session collection

    ## Initializes book with only specified keys of a hash-- possibly add where to buy later
    def initialize(hash)
        @title = title
        @author = author
        # @description = description
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

    def self.collection
        @@saved
    end

    def self.find_by_title(title)
        @@all.find do |book|
            if book.title == title
                book
            end
        end
    end

    # def self.list_name_from_history(book)
    #     book.ranks_history[0].map {|key,value| value if key == "list_name"}.compact.join.to_s
    # end

    # def self.rank_name_from_history(book)
    #     book.ranks_history[0].map {|key,value| value if key == "rank"}.compact.join.to_s
    # end

    def self.reset!
        @@all.clear
    end

end