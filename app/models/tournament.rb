#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Tournament table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

class Tournament < ActiveRecord::Base

	attr_accessible :name, :kind, :number_players, :number_rounds, :country, :city, :organizador, :email, :url, :open_registration, :information, :visible
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :name, :message => 'Nombre no puede estar en blanco'
	validates :name, :length   => { :maximum => 50, :message => 'Nombre demasiado largo' }, :uniqueness => { :case_sensitive => false, :message => 'Este nombre ya esta registrado' }

	validates_numericality_of :number_players, :even => "true", :greater_than => 0, :message => 'Jugadores debe de ser un numero par mayor que 0'
	validates_numericality_of :number_rounds, :message => 'Rondas debe de ser un numero par mayor que 0', :even => "true", :greater_than => 0
			
	validates :country, :length   => { :maximum => 50, :message => 'Pais demasiado largo'}			
	validates :city,  :length   => { :maximum => 50, :message => 'Ciudad demasiada larga' }
	validates :organizador,  :length   => { :maximum => 50, :message => 'Organizador demasiado largo' }
	validates :email, :format     => { :with => email_regex, :message => 'Formato correo no correcto' }
	validates :url,  :length   => { :maximum => 50, :message => 'Url demasiada larga' }
	validates :information,  :length   => { :maximum => 250, :message => 'Informacion demasiada larga' }			
end
