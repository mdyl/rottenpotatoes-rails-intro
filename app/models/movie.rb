class Movie < ActiveRecord::Base
	def self.movie_ratings
		possible_ratings = ['G', 'PG', 'PG-13', 'R']
		return possible_ratings
	end
	def self.start_ratings
		start_ratings = {"G" => 'G', "PG" => 'PG', "PG-13" => 'PG-13', "R" => 'R'}
		return start_ratings
	end
end
