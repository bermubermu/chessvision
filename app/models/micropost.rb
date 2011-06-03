#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Micropost table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

class Micropost < ActiveRecord::Base

	attr_accessible :coment

	validates_presence_of :coment, :message => 'Comentario no puede estar en blanco'
	validates :coment, :length   => { :maximum => 2040, :message => 'Comentario demasiado largo' }

end
