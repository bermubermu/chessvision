#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the news view and the database through new model.
#-------------------------------------------------------------------------------------------------------

class NoticesController < ApplicationController
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
		@notice = Notice.new(params[:notice])
		@notice.id_usuario = current_user.name
		@notice.id_usuario2 = current_user.id
		@notice.id_club = cookies[:last_club_id]
		@club = Club.find(id=@notice.id_club)

		if cookies[:langu]== "en"
			if @notice.save
				flash[:success] = "Post reported"
				redirect_to @club
			else
				@title = "Sign up"
				redirect_to @club
			end
		else
			if @notice.save
				flash[:success] = "Post Registrado"
				redirect_to @club
			else
				@title = "Registro"
				redirect_to @club
			end
		end
	end
	

	def destroy
		@notice = Post.find(params[:id])
		@club = Club.find(id=@notice.id_club)
		@notice.destroy
		redirect_to @club
	end
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

end

  
