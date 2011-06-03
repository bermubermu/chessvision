#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the microposts view and the database through micropost model.
#-------------------------------------------------------------------------------------------------------

class RequestsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	
	def new
		redirect_to root_path
	end
	def edit
		redirect_to root_path
	end
	def update
		redirect_to root_path
	end
	def show
		redirect_to root_path
	end
	def index
		redirect_to root_path
	end
  
	def create
		@request = Request.new(params[:request])
		@request.id_usuario = current_user.name
		@request.id_usuario2 = current_user.id
		@request.id_club = cookies[:last_club_id]
		@club = Club.find(id=@request.id_club)

		if cookies[:langu]== "en"
			if @request.save
				flash[:success] = "Post reported"
				redirect_to @club
			else
				@title = "Sign up"
				redirect_to @club
			end
		else
			if @request.save
				flash[:success] = "Post Registrado"
				redirect_to @club
			else
				@title = "Registro"
				redirect_to @club
			end
		end
	end
	

	def destroy
		@request = Request.find(params[:id])
		@club = Club.find(id=@request.id_club)

		@allowed = Allowed.new(@request.id)
		@allowed.id_usuario = @request.id_usuario
		@allowed.id_usuario2 = @request.id_usuario2
		@allowed.id_club = @request.id_club
		if @allowed.save
			@request.destroy
			redirect_to @club
		else
			flash[:success] = "Errorr no Registrado"
			redirect_to @club
		end
	end

	def destroyy
		@request = Request.find(params[:id])
		@club = Club.find(id=@request.id_club)
		@request.destroy
		redirect_to @club
	end
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

end

  
