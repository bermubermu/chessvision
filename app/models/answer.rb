class Answer < ActiveRecord::Base

	attr_accessible :reply

	validates_presence_of :reply, :message => 'Comentario no puede estar en blanco'
	validates :reply, :length   => { :maximum => 2040, :message => 'Comentario demasiado largo' }

end
