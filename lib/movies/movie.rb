module Movies
  class Movie
    attr_reader :title, 
                :release_date, 
                :genre, 
                :rating, 
                :studio

    def initialize(initial_details = {})
      @title = initial_details[:title]
      @release_date = initial_details[:release_date]
      @genre = initial_details[:genre]
      @studio = initial_details[:studio]
      @rating = initial_details[:rating]
    end

    def to_s
      "#{title}"
    end
  end
end
