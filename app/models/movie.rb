class Movie < ActiveRecord::Base
  #define an instance variable for @all_ratings
#   def initialize()
#     @all_ratings = ['G','PG','PG-13','R']
#   end
#   #getters 
  def self.all_ratings
#     {'G' => 1, 'PG' => 1,'PG-13' => 1,'R' => 1}
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
    Movie.where(rating: ratings_list)
  end
end
