#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the users view and the database through user model.
#-------------------------------------------------------------------------------------------------------

class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy, :show]
  before_filter :correct_user, :only => [:edit, :update]
  
	def index
		@users = User.paginate(:page => params[:page], :per_page => 11, :order => 'name ASC' )
		@user = User.new
		@prueba = cookies[:langu]
		if cookies[:langu]== "en"
			@title = "All users"
			@list = "All Users"
			@areyousure = "Will proceed to delete..."
		else
			@title = "Usuarios"
			@list = "Listado de Usuarios"
			@areyousure = "Se va a proceder a eliminar..."
		end
	end



	def show
		@user = User.find(params[:id])
		@title = @user.name
		@bookss = Book.paginate(:conditions => ["id_usuario=?", params[:id]], :page => params[:page], :per_page => 7, :order => 'event ASC' ) 
		if cookies[:langu]== "en"
			@name = "Name"
			@surname = "Surname"
			@email = "Email"
			@elo = "Elo"
			@phone = "Phone"
			@id= "Identifier"
			@reg = "Registered"
			@upd = "Updated"
			@day = "day"
			@edit = "Edit Profile"
			@shared = "Shared books"
			@of = "of"
			@news = "NEWS"
			@event = "EVENT"
			@site = "SITE"
			@date = "DATE"
			@areyousure = "Will proceed to delete..."
			@register = "New PGN"
			@tournament = "Tournament"
			@site = "Site"
			@player1 = "Player 1"
			@player2 = "Player 2"
			@date = "Date"
			@download = "Download"
		else
			@name = "Nombre"
			@surname = "Apellidos"
			@email = "Correo"
			@elo = "Elo"
			@phone = "Telefono"
			@id= "Identificador"
			@reg = "Registrado"
			@upd = "Actualizado"
			@day = "dia"
			@edit = "Editar Perfil"
			@shared = "Libros compartidos"
			@of = "de"
			@news = "NOVEDADES"
			@event = "EVENTO"
			@site = "LUGAR"
			@date = "FECHA"
			@areyousure = "Se va a proceder a eliminar..."
			@register = "Nuevo PGN"
			@tournament = "Torneo"
			@site = "Lugar"
			@player1 = "Jugador 1"
			@player2 = "Jugador 2"
			@date = "Fecha"
			@download = "Descargar"
		end

	end


	def new
		redirect_to users_path
	end

	def forgot
		if cookies[:langu]== "en"
			flash[:success] = "In short, we will send your new password."
			redirect_to english_path
		else
			flash[:success] = "En breve, le enviaremos su nueva clave."
			redirect_to root_path
		end
	end
  

	def create
		@users = User.paginate(:page => params[:page], :per_page => 11, :order => 'name ASC' )
		@user = User.new(params[:user])
		if cookies[:langu]== "en"
			if @user.save
				sign_in @user
				flash[:success] = "Welcome to Caporal"
				redirect_to @user
			else
				@title = "Sign up"
				render 'index'
			end
		else
			if @user.save
				sign_in @user
				flash[:success] = "Bienvenido a Caporal"
				redirect_to @user
			else
				@title = "Registro"
				render 'index'
			end
		end
	end
  

	def edit
		if cookies[:langu]== "en"
			@name = "Name"
			@surname = "Surname"
			@email = "Email"
			@elo = "Elo"
			@phone = "Phone"
			@title = "Edit user"
			@id= "Identifier"
			@reg = "Registered"
			@upd = "Updated"
			@day = "day"
			@edit = "Edit Profile"
		else
			@name = "Nombre"
			@surname = "Apellidos"
			@email = "Correo"
			@elo = "Elo"
			@phone = "Telefono"
			@title = "Editar usuario"
			@id= "Identificador"
			@reg = "Registrado"
			@upd = "Actualizado"
			@day = "dia"
			@edit = "Editar Perfil"
		end
	end


	def update
		@user = User.find(params[:id])
		if cookies[:langu]== "en"
			if @user.update_attributes(params[:user])
				flash[:success] = "Profile updated."
				redirect_to @user
			else
				@title = "Edit user"
				render 'edit'
			end
		else
			if @user.update_attributes(params[:user])
				flash[:success] = "Perfil Actualizado."
				redirect_to @user
			else
				@title = "Editar usuario"
				render 'edit'
			end
		end
	end


	def destroy
		User.find(params[:id]).destroy
		if cookies[:langu]== "en"
			flash[:success] = "User destroyed."
			redirect_to english_path
		else
			flash[:success] = "Usuario destruido."
			redirect_to root_path
		end
	end


  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
