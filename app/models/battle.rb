#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Battles table, providing a setting for it.
#-----------------------------------------------------------------------------------------------------

class Battle < ActiveRecord::Base
	attr_accessible :result, :round
end
