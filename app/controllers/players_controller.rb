#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the players view and the database through player model.
#-------------------------------------------------------------------------------------------------------

class PlayersController < ApplicationController
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
		@player = Player.new(params[:player])
		@player.id_usuario = current_user.name
		@player.id_usuario2 = current_user.id
		@player.score = 0
		@player.control = 0
		@player.control2 = 0
		@player.id_tournament = cookies[:last_tournament_id]
		@tournament = Tournament.find(id=@player.id_tournament)

		if cookies[:langu]== "en"
			if @player.save
				flash[:success] = "Player reported"
				redirect_to @tournament
			else
				@title = "Sign up"
				redirect_to @tournament
			end
		else
			if @player.save
				flash[:success] = "Jugador Registrado"
				redirect_to @tournament
			else
				@title = "Registro"
				redirect_to @tournament
			end
		end
	end
	

	def destroy
		@player = Player.find(params[:id])
		@tournament = Tournament.find(id=@player.id_tournament)
		@player.destroy
		redirect_to @tournament
	end


	
	private

		def authenticate
		  deny_access unless signed_in?
		end

end

  
