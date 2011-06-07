class Problem < ActiveRecord::Base

	attr_accessible :name, :question, :picture

	validates_presence_of :name, :message => 'Nombre no puede estar en blanco'
	validates :name, :length   => { :maximum => 50, :message => 'Nombre demasiado largo' }

	validates_presence_of :question, :message => 'Pregunta no puede estar en blanco'
	validates :question, :length   => { :maximum => 2040, :message => 'Pregunta demasiada larga' }

  has_attached_file :picture, :styles => { :thumb=> "100x100#", :small  => "150x150>" }, :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :url  => '/pictures/:style/:basename.:extension', :path => 'pictures/:style/:basename.:extension', :bucket => 'albertorecurso'


end
