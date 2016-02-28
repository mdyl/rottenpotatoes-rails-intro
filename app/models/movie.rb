class Movie < ActiveRecord::Base
	def self.movie_ratings
		possible_ratings = ['G', 'PG', 'PG-13', 'R']
		return possible_ratings
	end
end
