class Book

    attr_accessor :title, :rank, :author, :description

    @@all = []

    def initialize(data_hash)
        student_hash.each { |key,value| self.send(("#{key}="), value)}
        binding.pry
        @@all << self
    end 

    def self.create_from_hash(hash)


    end



end