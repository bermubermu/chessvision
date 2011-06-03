#-------------------------------------------------------------------------------------------------------
# This class manages the access to an object in the User table, providing a setting for it.
#-------------------------------------------------------------------------------------------------------

require 'digest'
class User < ActiveRecord::Base
  
	attr_accessor :password
	attr_accessible :name, :surname, :email, :phone, :elo, :password, :password_confirmation

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates_presence_of :name, :message => 'Nombre no puede estar en blanco'
	validates :name, :length   => { :maximum => 50, :message => 'Nombre demasiado largo' }

	validates :phone, :length   => { :maximum => 50, :message => 'Demasiadas cifras' }
	validates :elo, :length   => { :maximum => 4, :message => 'Elo demasiado largo' }

	validates_presence_of :email, :message => 'Correo no puede estar en blanco'
	validates :email, :format     => { :with => email_regex, :message => 'Formato correo no correcto' }, :uniqueness => { :case_sensitive => false, :message => 'Este correo ya esta registrado' }

	validates_presence_of :password, :message => 'Password no puede estar en blanco'
	validates :password, :confirmation => true, :length   => { :within => 6..40, :message => 'Password longitud no correcta (6 a 40 caracteres)' }


					   
  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
