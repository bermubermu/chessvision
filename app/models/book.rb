#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Book table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

class Book < ActiveRecord::Base
    mount_uploader :attachment, AttachmentUploader

	attr_accessible :event, :round, :site, :white, :elo_white, :black, :elo_black, :date, :result, :eco, :attachment, :description

	validates_presence_of :event, :message => 'Evento no puede estar en blanco'
	validates :event, :length   => { :maximum => 50, :message => 'Evento demasiado largo' }
	validates :round, :length   => { :maximum => 4, :message => 'Ronda demasiado largo' }
	validates :site, :length   => { :maximum => 50, :message => 'Lugar demasiado largo' }
	validates :white, :length   => { :maximum => 50, :message => 'Jugador Blancas demasiado largo' }			
	validates :elo_white, :length   => { :maximum => 4, :message => 'Elo jugador Blancas demasiado largo'}			
	validates :black,  :length   => { :maximum => 50, :message => 'Jugador Negras demasiado largo' }
	validates :elo_black, :length   => { :maximum => 4, :message => 'Elo jugador Negras demasiado largo' }			
	validates :date,  :length   => { :maximum => 4, :message => 'Fecha demasiada larga' }
	validates_presence_of :attachment, :message => 'Fichero no correcto'
	validates :description,  :length   => { :maximum => 250, :message => 'Comentario demasiada larga' }			
end
