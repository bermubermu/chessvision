#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Player table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

class Player < ActiveRecord::Base
	attr_accessible :score, :control, :control2
end
