class Post < ActiveRecord::Base
	attr_accessible :coment

	validates_presence_of :coment, :message => 'Comentario no puede estar en blanco'
	validates :coment, :length   => { :maximum => 2040, :message => 'Comentario demasiado largo' }
end
