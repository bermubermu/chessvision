#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the microposts view and the database through micropost model.
#-------------------------------------------------------------------------------------------------------

class AllowedsController < ApplicationController
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
		redirect_to root_path
	end
	
	def destroy
		@allowed = Allowed.find(params[:id])
		@club = Club.find(id=@allowed.id_club)
		@allowed.destroy
		redirect_to @club

	end

end

  
