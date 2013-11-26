<<-WELCOME

The primary goals of this excercise are to both gauge your comfortability level with the Ruby language and some of its characteristics. More importantly, this excercise will also be used as an initial gauge of design proficiency.

Some of the constraints for the excercise are as follows:

- Enumerable (Limited to use of just the following methods)
  - sort
  - count
  - include?
  - each

- Array (Limited to use of just the following methods)
  - dup
  - <<
  - []

- lib/genres.rb and lib/studios.rb cannot be modified
  - You also cannot monkey patch these modules

WELCOME

require_relative '../spec_helper'

def create_movie(details={})
  ::Movies::Movie.new(details)
end

describe 'general movie functionality' do
  Given(:movies){ [] }
  Given(:sut) { ::Movies::MovieLibrary.new(movies) }

  describe 'Can return a list of all of its movies' do
    Given(:first_movie) { create_movie }
    Given(:second_movie) { create_movie }

    Given do
      movies.push(first_movie)
      movies.push(second_movie)
    end

    When(:results) { sut.all }

    Then { results.only_contains?(first_movie, second_movie) }
  end

  describe 'Movie can be added to its list of movies' do
    Given(:movie) { create_movie }

    When { sut.add(movie) }

    Then { movies.include?(movie) }
  end

  describe 'Cannot add multiple copies of the same movie' do
    Given(:movie) { create_movie }
    Given do
      movies << movie
    end

    When { sut.add(movie) }

    Then { movies.count == 1 }
  end

  describe 'Cannot add two movies that have the same title (logically the same)' do
    Given(:speed_racer) { create_movie(:title => 'Speed Racer') }
    Given(:another_copy_of_speed_racer) { create_movie(:title => 'Speed Racer') }
    Given do
      movies.push(speed_racer)
    end

    When { sut.add(another_copy_of_speed_racer) }

    Then { movies.count == 1 }
  end

  describe 'searching and sorting' do
    Given(:indiana_jones_and_the_temple_of_doom) { create_movie :title => "Indiana Jones And The Temple Of Doom", :release_date => Time.new(1982, 1, 1), :genre => Movies::Genres::ACTION, :studio => Movies::Studios::UNIVERSAL, :rating => 10 }

    Given(:cars) { create_movie :title => "Cars", :release_date => Time.new(2004, 1, 1), :genre => Movies::Genres::KIDS, :studio => Movies::Studios::PIXAR, :rating => 10 }

    Given(:your_mine_and_ours) { create_movie :title => "Yours, Mine and Ours", :release_date => Time.new(2005, 1, 1), :genre => Movies::Genres::COMEDY, :studio => Movies::Studios::MGM, :rating => 7 }

    Given(:shrek) { create_movie :title => "Shrek", :release_date => Time.new(2006, 5, 10), :genre => Movies::Genres::KIDS, :studio => Movies::Studios::DREAMWORKS, :rating => 10 }

    Given(:a_bugs_life) { create_movie :title => "A Bugs Life", :release_date => Time.new(2000, 6, 20), :genre => Movies::Genres::KIDS, :studio => Movies::Studios::PIXAR, :rating => 10 }

    Given(:theres_something_about_mary) { create_movie :title => "There's Something About Mary", :release_date => Time.new(2007, 1, 1), :genre => Movies::Genres::COMEDY, :studio => Movies::Studios::MGM, :rating => 5 }

    Given(:pirates_of_the_carribean) { create_movie :title => "Pirates of the Carribean", :release_date => Time.new(2003, 1, 1), :genre => Movies::Genres::ACTION, :studio => Movies::Studios::DISNEY, :rating => 10 }

    Given(:original_movies) do
      [
        indiana_jones_and_the_temple_of_doom,
        cars,
        a_bugs_life,
        theres_something_about_mary,
        pirates_of_the_carribean,
        your_mine_and_ours,
        shrek
      ]
    end

    describe 'Searching for movies' do
      Given(:sut) do
        movies = original_movies.dup
        ::Movies::MovieLibrary.new(movies)
      end

      describe 'Can find all pixar movies' do
        When(:results) { sut.all_movies_published_by_pixar }

        Then { results.to_a.eql?([cars, a_bugs_life])}
      end

      describe 'Can find all movies published by pixar or disney' do
        When(:results) { sut.all_movies_published_by_pixar_or_disney }

        Then { results.contains?(cars, a_bugs_life, pirates_of_the_carribean)}
      end

      describe 'Can find all movies not published by pixar' do
        When(:results) { sut.all_movies_not_published_by_pixar }

        Then { ! results.contains?(cars, a_bugs_life)}
      end

      describe 'Can find all movies released after 2004' do
        When(:results) { sut.all_movies_published_after_year(2004) }

        Then { results.contains?(your_mine_and_ours, shrek, theres_something_about_mary) }
      end

      describe 'Can find all movies released between 1982 and 2003 - Inclusive' do
        When(:results) { sut.all_movies_published_between_years(1982, 2003) }

        Then { results.contains?(indiana_jones_and_the_temple_of_doom, a_bugs_life, pirates_of_the_carribean) }
      end
    end

    describe 'Sorting movies' do
      describe 'Sorts all movies by descending title' do
        When(:results) { sut.sort_all_movies_by_title_descending }

        Then { results.eql? [theres_something_about_mary, your_mine_and_ours, shrek, pirates_of_the_carribean, indiana_jones_and_the_temple_of_doom, cars, a_bugs_life] }
      end

      describe 'Sorts all movies by ascending title' do
        When(:results) { sut.sort_all_movies_by_title_ascending }

        Then { results.eql? [a_bugs_life, cars, indiana_jones_and_the_temple_of_doom, pirates_of_the_carribean, shrek, your_mine_and_ours, theres_something_about_mary] }
      end

      describe 'Sorts all movies by descending release date' do
        When(:results) { sut.sort_all_movies_by_release_date_descending }

        Then { results.eql? [theres_something_about_mary, shrek, your_mine_and_ours, cars, pirates_of_the_carribean, a_bugs_life, indiana_jones_and_the_temple_of_doom] }
      end

      describe 'Sorts all movies by ascending release date' do
        When(:results) { sut.sort_all_movies_by_release_date_ascending }

        Then { results.eql? [indiana_jones_and_the_temple_of_doom, a_bugs_life, pirates_of_the_carribean, cars, your_mine_and_ours, shrek, theres_something_about_mary] }
      end

      describe 'Sorts all movies by preferred studios and release date ascending' do
        <<-SPEC
   In this spec the results of the movies should be sorted as follows:
    MGM Movies
     - By ascending release date
    Pixar Movies
     - By ascending release date
    Dreamworks Movies
     - By ascending release date
    Universal Movies
     - By ascending release date
    Disney Movies
     - By ascending release date

        SPEC

        When(:results) { sut.sort_all_movies_by_studio_preference_and_year_published }

        Then { results.eql? [your_mine_and_ours, theres_something_about_mary, a_bugs_life, cars, shrek, indiana_jones_and_the_temple_of_doom, pirates_of_the_carribean] }
      end
    end
  end
end
