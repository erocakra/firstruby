class Employee < ActiveRecord::Base
	scope :location, -> (location) { where location: location }
end

