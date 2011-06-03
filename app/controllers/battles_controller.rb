#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the players view and the database through player model.
#-------------------------------------------------------------------------------------------------------

class BattlesController < ApplicationController
	before_filter :authenticate, :only => [:show, :update]
	before_filter :correct_user2, :only => [:update]
	before_filter :correct_user, :only => [:show]
	
	def new
		redirect_to root_path
	end
	def edit
		redirect_to root_path
	end
	def show
		@battle = Battle.find(params[:id])
		@tournament = Tournament.find(cookies[:last_tournament_id])

		@n1 =  @tournament.name.downcase
		@n2 =  @tournament.name.upcase
		@n3 =  @tournament.name.capitalize
		@n4 =  @tournament.name.titleize
		@m1 =  @battle.id_usuario1.downcase
		@m2 =  @battle.id_usuario1.upcase
		@m3 =  @battle.id_usuario1.capitalize
		@m4 =  @battle.id_usuario1.titleize
		@o1 =  @battle.id_usuario3.downcase
		@o2 =  @battle.id_usuario3.upcase
		@o3 =  @battle.id_usuario3.capitalize
		@o4 =  @battle.id_usuario3.titleize

		@book = Book.find(:first, :conditions => ["((event=? OR event=? OR event=? OR event=? OR event=?) AND round=? AND (white=? OR white=? OR white=? OR white=? OR white=?) AND (black=? OR black=? OR black=? OR black=? OR black=?))", @tournament.name, @n1, @n2, @n3, @n4, @battle.round, @battle.id_usuario1, @m1, @m2, @m3, @m4, @battle.id_usuario3, @o1, @o2, @o3, @o4,])
		if !@book
			@vvv=0
		else
			@vvv=1
		end

		@tournament = Tournament.find(cookies[:last_tournament_id])
		@battle = Battle.find(params[:id])

if (current_user.admin? || current_user.id == @battle.id_usuario2 || current_user.id == @battle.id_usuario4 || current_user.id==@tournament.id_usuario)
	@per=0
else
	@per=1
end


	end
	def update
		@tournament = Tournament.find(cookies[:last_tournament_id])
		@battle = Battle.find(params[:id])
		@result1 = @battle.result

		if cookies[:langu]== "en"
			if @battle.update_attributes(params[:battle])
				@battle = Battle.find(params[:id])
				@result2=@battle.result
				if(@result1 != @result2)
					if(@result2 == 0)
						@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
						@score =  @player.score
						@player.update_attribute(:score, @score+1)
						if(@result1 == 0.5)
							@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score1 =  @player1.score
							@score2 =  @player2.score
							@player1.update_attribute(:score, @score1-0.5)
							@player2.update_attribute(:score, @score2-0.5)
						end
						if(@result1 == 1)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
					end
					if(@result2 == 0.5)
						@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
						@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
						@score1 =  @player1.score
						@score2 =  @player2.score
						@player1.update_attribute(:score, @score1+0.5)
						@player2.update_attribute(:score, @score2+0.5)
						if(@result1 == 0)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
						if(@result1 == 1)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
					end
					if(@result2 == 1)
						@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
						@score =  @player.score
						@player.update_attribute(:score, @score+1)
						if(@result1 == 0)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
						if(@result1 == 0.5)
							@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score1 =  @player1.score
							@score2 =  @player2.score
							@player1.update_attribute(:score, @score1-0.5)
							@player2.update_attribute(:score, @score2-0.5)
						end
					end
				end
				flash[:success] = "Result upgraded."
				redirect_to versus_path
			else
			  @title = "Edit Result"
			  render 'edit'
			end
		else
			if @battle.update_attributes(params[:battle])
				@result2=@battle.result
				if(@result1 != @result2 )
					if(@result2 == 0)
						@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
						@score =  @player.score
						@player.update_attribute(:score, @score+1)
						if(@result1 == 0.5)
							@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score1 =  @player1.score
							@score2 =  @player2.score
							@player1.update_attribute(:score, @score1-0.5)
							@player2.update_attribute(:score, @score2-0.5)
						end
						if(@result1 == 1)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
					end
					if(@result2 == 0.5)
						@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
						@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
						@score1 =  @player1.score
						@score2 =  @player2.score
						@player1.update_attribute(:score, @score1+0.5)
						@player2.update_attribute(:score, @score2+0.5)
						if(@result1 == 0)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
						if(@result1 == 1)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
					end
					if(@result2 == 1)
						@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
						@score =  @player.score
						@player.update_attribute(:score, @score+1)
						if(@result1 == 0)
							@player = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@score =  @player.score
							@player.update_attribute(:score, @score-1)
						end
						if(@result1 == 0.5)
							@player1 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario2, @tournament.id])
							@player2 = Player.find(:first, :conditions => ["id_usuario2=? AND id_tournament=?", @battle.id_usuario4, @tournament.id])
							@score1 =  @player1.score
							@score2 =  @player2.score
							@player1.update_attribute(:score, @score1-0.5)
							@player2.update_attribute(:score, @score2-0.5)
						end
					end
				end
				flash[:success] = "Resultado actualizados."
				redirect_to versus_path
			else
			  @title = "Editar Resultado"
			  render 'edit'
			end
		end
	end
	def index
		redirect_to root_path
	end
	def create
		redirect_to root_path
	end
	

	def destroy
		redirect_to root_path
	end


	
	private

		def authenticate
		  deny_access unless signed_in?
		end

		def correct_user2
			@tournament = Tournament.find(cookies[:last_tournament_id])
			@battle = Battle.find(params[:id])

			@user1 = User.find(id=@tournament.id_usuario) 
			@user2 = User.find(id=@battle.id_usuario2) 
			@user3 = User.find(id=@battle.id_usuario4) 

			redirect_to(versus_path) unless current_user?(@user1) unless current_user?(@user2) unless current_user?(@user3) unless current_user.admin?
		end

	   def correct_user
		@tournament = Tournament.find(cookies[:last_tournament_id])
		@player2 = Player.new(0)
		@player2.id_usuario = 0
		@player2.id_usuario2 = 0
		@player2.id_tournament = 0
		@player2.save

		@add = Player.find(:first, :conditions => ["(id_usuario2=? AND id_tournament=?) OR id=?", current_user.id, @tournament.id, @player2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@tournament.id_usuario)
			@player2.destroy
		else
			if @tournament.visible == "public" || @tournament.visible == "publico"
				@player2.destroy
			else
				@player2.destroy
				redirect_to(tournaments_path)
			end
		end
            end

end















  
