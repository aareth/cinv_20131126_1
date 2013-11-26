module Movies
  class Genre
    include Initializer

    initializer :name

    def to_s
      name
    end
  end

  module Genres
    KIDS = Genre.new("Kids")
    ACTION = Genre.new("Action")
    COMEDY = Genre.new("Comedy")
    HORROR = Genre.new("Horror")
  end
end
