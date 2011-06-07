class Problem < ActiveRecord::Base

	attr_accessible :name, :question, :picture

	validates_presence_of :name, :message => 'Nombre no puede estar en blanco'
	validates :name, :length   => { :maximum => 50, :message => 'Nombre demasiado largo' }

	validates_presence_of :question, :message => 'Pregunta no puede estar en blanco'
	validates :question, :length   => { :maximum => 2040, :message => 'Pregunta demasiada larga' }






end
