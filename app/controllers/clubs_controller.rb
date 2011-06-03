#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the clubs view and the database through clubs model.
#-------------------------------------------------------------------------------------------------------

class ClubsController < ApplicationController

before_filter :authenticate, :only => [:board, :news, :friend, :requestt, :show, :edit, :update, :destroy, :new, :create, :index]
	before_filter :correct_user, :only => [:board, :news, :friends]
	before_filter :correct_user2, :only => [:edit, :requestt, :destroy]


	def index
		@clubs = Club.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 20 ) 
		if cookies[:langu]== "en"
			@title = "Club"
			@name = "Name"
			@email = "E-mail"
			@site = "Site"
			@person = "President"
			@nclub="New Club"
		else
			@title = "Club"
			@name = "Nombre"
			@email = "Correo"
			@site = "Lugar"
			@person = "Presidente"
			@nclub="Nuevo Club"
		end
	end


	def show
		if cookies[:langu]== "en"
			@name = "Name"
			@adrres = "Address"
			@person = "President"
			@email = "E-mail"
			@phone = "Phone"
			@date = "Founded"
			@created = "Created"
			@updated = "Updated"
			@day = "day"
			@information = "Information"
			@news = "News"
			@board = "Board"
			@friends = "Friends"
			@configuration = "Configuration >>"
			@request_ac = "Request"
		else
			@name = "Nombre"
			@adrres = "Lugar"
			@person = "Presidente"
			@email = "Correo"
			@phone = "Telefono"
			@date = "Fundado"
			@created = "Creado"
			@updated = "Actualizado"
			@day = "dia"
			@information = "Datos"
			@news = "Noticias"
			@board = "Tablon"
			@friends = "Amigos"
			@configuration = "Configuracion >>"
			@request_ac = "Solicitudes"
		end

		@club = Club.find(params[:id])
		@user_club = User.find(id=@club.id_usuario)
		@title = @club.name
		@request = Request.new
		@allowed = Allowed.new
		cookies[:last_club_id] = @club.id 
		@requestss = Request.paginate(:page => params[:page], :per_page => 3, :conditions => ["id_club=?", params[:id]], :order => 'created_at DESC' )

		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = @request.id_usuario
		@allowed2.id_usuario2 = @request.id_usuario2
		@allowed2.id_club = @request.id_club
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@add2="uno"
			if current_user.id==@club.id_usuario
				@add2="dos"
			end
		else
			@add2="tres"
		end

		@allowed2.destroy
	end


	def requestt
		if cookies[:langu]== "en"
			@name = "Name"
			@adrres = "Address"
			@person = "President"
			@email = "E-mail"
			@phone = "Phone"
			@date = "Founded"
			@created = "Created"
			@updated = "Updated"
			@day = "day"
			@information = "Information"
			@news = "News"
			@board = "Board"
			@friends = "Friends"
			@configuration = "Configuration"
			@request_ac = "Request"
		else
			@name = "Nombre"
			@adrres = "Lugar"
			@person = "Presidente"
			@email = "Correo"
			@phone = "Telefono"
			@date = "Fundado"
			@created = "Creado"
			@updated = "Actualizado"
			@day = "dia"
			@information = "Datos"
			@news = "Noticias"
			@board = "Tablon"
			@friends = "Amigos"
			@configuration = "Configuracion"
			@request_ac = "Solicitudes"
		end

		@club = Club.find(cookies[:last_club_id])
		@title = @club.name
		@requestss = Request.paginate(:page => params[:page], :per_page => 5, :conditions => ["id_club=?", @club.id], :order => 'created_at DESC' )

		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = 0
		@allowed2.id_usuario2 = 0
		@allowed2.id_club = 0
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@add2="uno"
			if current_user.id==@club.id_usuario
				@add2="dos"
			end
		else
			@add2="tres"
		end
		@allowed2.destroy

	end


	def friends
		if cookies[:langu]== "en"
			@name = "Name"
			@adrres = "Address"
			@person = "President"
			@email = "E-mail"
			@phone = "Phone"
			@date = "Founded"
			@created = "Created"
			@updated = "Updated"
			@day = "day"
			@information = "Information"
			@news = "News"
			@board = "Board"
			@friends = "Friends"
			@configuration = "Configuration"
			@request_ac = "Request"
		else
			@name = "Nombre"
			@adrres = "Lugar"
			@person = "Presidente"
			@email = "Correo"
			@phone = "Telefono"
			@date = "Fundado"
			@created = "Creado"
			@updated = "Actualizado"
			@day = "dia"
			@information = "Datos"
			@news = "Noticias"
			@board = "Tablon"
			@friends = "Amigos"
			@configuration = "Configuracion"
			@request_ac = "Solicitudes"
		end

		@club = Club.find(cookies[:last_club_id])
		@title = @club.name
		@frienddd = Allowed.paginate(:page => params[:page], :per_page => 6, :conditions => ["id_club=?", @club.id], :order => 'created_at DESC' )


		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = 0
		@allowed2.id_usuario2 = 0
		@allowed2.id_club = 0
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@add2="uno"
			if current_user.id==@club.id_usuario
				@add2="dos"
			end
		else
			@add2="tres"
		end
		@allowed2.destroy

	end

	def news
		if cookies[:langu]== "en"
			@name = "Name"
			@adrres = "Address"
			@person = "President"
			@email = "E-mail"
			@phone = "Phone"
			@date = "Founded"
			@created = "Created"
			@updated = "Updated"
			@day = "day"
			@information = "Information"
			@news = "News"
			@board = "Board"
			@friends = "Friends"
			@configuration = "Configuration"
			@request_ac = "Request"
			@not = "Actually news of this Club."
		else
			@name = "Nombre"
			@adrres = "Lugar"
			@person = "Presidente"
			@email = "Correo"
			@phone = "Telefono"
			@date = "Fundado"
			@created = "Creado"
			@updated = "Actualizado"
			@day = "dia"
			@information = "Datos"
			@news = "Noticias"
			@board = "Tablon"
			@friends = "Amigos"
			@configuration = "Configuracion"
			@request_ac = "Solicitudes"
			@not = "Noticias Actualizadas por parte del Club."
		end

		@club = Club.find(cookies[:last_club_id])
		@title = @club.name
		cookies[:last_club_id] = @club.id 
		@notice = Notice.new
		@noticess = Notice.paginate(:page => params[:page], :per_page => 8, :conditions => ["id_club=?", @club.id], :order => 'created_at DESC' )

		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = 0
		@allowed2.id_usuario2 = 0
		@allowed2.id_club = 0
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@add2="uno"
			if current_user.id==@club.id_usuario
				@add2="dos"
			end
		else
			@add2="tres"
		end
		@allowed2.destroy
	end

	def board
		if cookies[:langu]== "en"
			@name = "Name"
			@adrres = "Address"
			@person = "President"
			@email = "E-mail"
			@phone = "Phone"
			@date = "Founded"
			@created = "Created"
			@updated = "Updated"
			@day = "day"
			@information = "Information"
			@news = "News"
			@board = "Board"
			@friends = "Friends"
			@configuration = "Configuration"
			@request_ac = "Request"
		else
			@name = "Nombre"
			@adrres = "Lugar"
			@person = "Presidente"
			@email = "Correo"
			@phone = "Telefono"
			@date = "Fundado"
			@created = "Creado"
			@updated = "Actualizado"
			@day = "dia"
			@information = "Datos"
			@news = "Noticias"
			@board = "Tablon"
			@friends = "Amigos"
			@configuration = "Configuracion"
			@request_ac = "Solicitudes"
		end

		@club = Club.find(cookies[:last_club_id])
		@title = @club.name
		cookies[:last_club_id] = @club.id 
		@post = Post.new
		@postss = Post.paginate(:page => params[:page], :per_page => 8, :conditions => ["id_club=?", @club.id], :order => 'created_at DESC' )

		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = 0
		@allowed2.id_usuario2 = 0
		@allowed2.id_club = 0
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@add2="uno"
			if current_user.id==@club.id_usuario
				@add2="dos"
			end
		else
			@add2="tres"
		end
		@allowed2.destroy
	end
	

	def new
		@club = Club.new
		if cookies[:langu]== "en"
			@title = "New Club"
			@msgg = "Registry club"
		else
			@title = "Nuevo Club"
			@msgg = "Registro de Club"
		end
	end
  

	def create
		@club = Club.new(params[:club])
		@club.id_usuario = current_user.id
		if cookies[:langu]== "en"
			if @club.save
				flash[:success] = "Club registered"
				redirect_to @club
			else
				@title = "Sign up"
				render 'new'
			end
		else
			if @club.save
				flash[:success] = "Club Registrado"
				redirect_to @club
			else
				@title = "Registro"
				render 'new'
			end
		end
	end

  
	def edit
		@club = Club.find(params[:id])
	end
  

	def update
		@club = Club.find(params[:id])
		if cookies[:langu]== "en"
			if @club.update_attributes(params[:club])
			  flash[:success] = "Club upgraded."
			  redirect_to @club
			else
			  @title = "Edit Club"
			  render 'edit'
			end
		else
			if @club.update_attributes(params[:club])
			  flash[:success] = "Club Actualizado"
			  redirect_to @club
			else
			  @title = "Editar Club"
			  render 'edit'
			end
		end
	end
  
	def destroy
		@club = Club.find(params[:id])
		@club.destroy
		if cookies[:langu]== "en"
			flash[:success] = "Club destroyed"
		else
			flash[:success] = "Club Destruido"
		end
		redirect_to clubs_path
	end


	private

		def authenticate
		  deny_access unless signed_in?
		end

	   def correct_user
		@club = Club.find(cookies[:last_club_id])
		@allowed2 = Allowed.new(0)
		@allowed2.id_usuario = 0
		@allowed2.id_usuario2 = 0
		@allowed2.id_club = 0
		@allowed2.save

		@add = Allowed.find(:first, :conditions => ["(id_usuario2=? AND id_club=?) OR id=?", current_user.id, @club.id, @allowed2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@club.id_usuario)
			@allowed2.destroy
		else
			@allowed2.destroy
			redirect_to(clubs_path)
		end
            end


	   def correct_user2
		@club = Club.find(cookies[:last_club_id])
		@user = User.find(id=@club.id_usuario) 
		redirect_to(clubs_path) unless current_user?(@user) unless current_user.admin?

            end







end
