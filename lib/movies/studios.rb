module Movies
  class Studio
    include Initializer

    initializer :name
  end

  module Studios
    PIXAR = Studio.new("Pixar")
    UNIVERSAL = Studio.new("Universal")
    MGM = Studio.new("Mgm")
    DISNEY = Studio.new("Disney")
    DREAMWORKS = Studio.new("Dreamworks")
    PARAMOUNT = Studio.new("Paramount")
  end
end
