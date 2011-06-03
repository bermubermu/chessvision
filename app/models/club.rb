#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the Club table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

class Club < ActiveRecord::Base

	attr_accessible :name, :email, :address, :province, :person, :phone, :date, :information
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :name, :message => 'Nombre no puede estar en blanco'
	validates :name, :length   => { :maximum => 50, :message => 'Nombre demasiado largo' }

	validates :email, :format     => { :with => email_regex, :message => 'Formato correo no correcto' }, :uniqueness => { :case_sensitive => false, :message => 'Este correo ya esta registrado' }

	validates :address, :length   => { :maximum => 50, :message => 'Direccion demasiada largo' }
	validates :province, :length   => { :maximum => 50, :message => 'Provincia demasiada largo' }			
	validates :person, :length   => { :maximum => 50, :message => 'Persona demasiada largo'}			
	validates :phone,  :length   => { :maximum => 50, :message => 'Telefono demasiado largo' }
	validates :date,  :length   => { :maximum => 4, :message => 'Ano demasiado larga' }
	validates :information,  :length   => { :maximum => 250, :message => 'Informacion demasiada larga' }			
end



