class NytCli::Book

    attr_accessor :title, :author, :rank, :description

    @@all = []

    ## Initializes book with only specified keys of a hash-- possibly add where to buy later
    def initialize(hash)
        @title = title
        @author = author
        @rank = rank
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


end