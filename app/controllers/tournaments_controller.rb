#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the clubs view and the database through clubs model.
#-------------------------------------------------------------------------------------------------------

class TournamentsController < ApplicationController

	before_filter :authenticate, :only => [:show, :edit, :update, :destroy, :new, :create, :index, :participants, :versus, :classification]
	before_filter :correct_user2, :only => [:edit, :destroy]
	before_filter :correct_user, :only => [:participants, :versus, :classification]


	def index
		@tournaments = Tournament.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 20 ) 
		if cookies[:langu]== "en"
			@title = "Tournament"
			@name = "Name"
			@players = "Players"
			@rounds = "Rounds"
			@country = "Country"
			@kind = "Kind"
			@ntournament="New Championship"
		else
			@title = "Torneo"
			@name = "Nombre"
			@players = "Jugadores"
			@rounds = "Rondas"
			@country = "Pais"
			@kind = "Tipo"
			@ntournament="Nuevo Campeonato"
		end
	end


	def show
		@tournament = Tournament.find(params[:id])
		if cookies[:langu]== "en"
			@name = "Name"
			@address = "Address"
			@kind = "Kind"
			@n_players = "Players"
			@n_rounds = "Rounds"
			@person = "Club"
			@email = "Email"
			@web = "URL"
			@created = "Created"
			@day = "day"
			@configuration = "Configuration >>"
			@information = "Information"
			@play = "Players"
			@vs = "Games"
			@classi = "Classification"
			@acces = "Acces"
			@restt = "Missing"
			@rest = "player/s to start"
			if @tournament.visible == "public" || @tournament.visible == "publico" 
				@visible = "Public"
			else
				@visible = "Private"
			end
		else
			@name = "Nombre"
			@address = "Lugar"
			@kind = "Tipo"
			@n_players = "Jugadores"
			@n_rounds = "Rondas"
			@person = "Club"
			@email = "Email"
			@web = "URL"
			@created = "Creado"
			@day = "dia"
			@configuration = "Configuracion >>"
			@information = "Datos"
			@play = "Jugadores"
			@vs = "Encuentros"
			@classi = "Clasificacion"
			@acces = "Acceso"
			@restt = "Faltan"
			@rest = "jugador/es para empezar"
			if @tournament.visible == "public" || @tournament.visible == "publico" 
				@visible = "Publico"
			else
				@visible = "Privado"
			end
		end

		@tournament = Tournament.find(cookies[:last_tournament_id])
		@n1 =  @tournament.organizador.downcase
		@n2 =  @tournament.organizador.upcase
		@n3 =  @tournament.organizador.capitalize
		@n4 =  @tournament.organizador.titleize

		@cluba = Club.find(:first, :conditions => ["(name=? OR name=? OR name=? OR name=? OR name=?)", @tournament.organizador, @n1, @n2, @n3, @n4])
		if !@cluba
			@vvv=0
		else
			@vvv=1
		end


		@user_tournament = User.find(id=@tournament.id_usuario)
		@title = @tournament.name
		@player = Player.new
		cookies[:last_tournament_id] = @tournament.id

		@rounds=@tournament.number_rounds
		@coon=Player.count(:all, :conditions => ["id_tournament=?", @tournament.id])
		@coom3=@tournament.number_players
		@resto=@coom3-@coon
		if (@coon == @coom3)
			@add3="uno"
		else
			@add3="dos"
		end

		@battle2 = Battle.new(0)
		@battle2.id_tournament = 0
		@battle2.save

		if (@tournament.kind == "League" || @tournament.kind == "Liga")
			@bata=Battle.count(:all, :conditions => ["id_tournament=?", @tournament.id])
			@cuuuu=Battle.find(:first, :conditions => ["(id_tournament=? AND result=?) OR id=?", @tournament.id, 4, @battle2.id])
			if(@cuuuu.id == @battle2.id && @bata!=0)
				if cookies[:langu]== "en"
					@pp44="LEAGUE ENDED"
				else
					@pp44="LIGA FINALIZADA"
				end
			end
		else
			@cuouu=Battle.find(:first, :conditions => ["(id_tournament=? AND round=?) OR id=?", @tournament.id, @rounds, @battle2.id])
			if(@cuouu.id != @battle2.id)
				@cuuuu=Battle.find(:first, :conditions => ["(id_tournament=? AND round=? AND result=?) OR id=?", @tournament.id, @rounds, 4, @battle2.id])
				if(@cuuuu.id == @battle2.id)
					if cookies[:langu]== "en"
						@pp44="TOURNAMENT ENDED"
					else
						@pp44="TORNEO FINALIZADO"
					end
				end
			end
		end


		@battle2.destroy 


		@player2 = Player.new(0)
		@player2.id_usuario = 0
		@player2.id_usuario2 = 0
		@player2.id_tournament = 0
		@player2.save

		@add = Player.find(:first, :conditions => ["(id_usuario2=? AND id_tournament=?) OR id=?", current_user.id, @tournament.id, @player2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@tournament.id_usuario)
			@add2="uno"
			if current_user.id==@tournament.id_usuario
				@add2="dos"
			end
			if @tournament.id_usuario == @add.id_usuario2
				@add0="uno"
			end
		else
			if @tournament.visible == "public" || @tournament.visible == "publico"
				@add6="cuatro"
			end
			@add2="tres"
		end
		@player2.destroy 
	end



	def participants
		if cookies[:langu]== "en"
			@information = "Information"
			@play = "Players"
			@vs = "Games"
			@classi = "Classification"
		else
			@information = "Datos"
			@play = "Jugadores"
			@vs = "Encuentros"
			@classi = "Clasificacion"
		end
		@tournament = Tournament.find(cookies[:last_tournament_id])
		@title = @tournament.name
		@playerdd = Player.paginate(:page => params[:page], :per_page => 6, :conditions => ["id_tournament=?", @tournament.id], :order => 'created_at DESC' )


		@player2 = Player.new(0)
		@player2.id_usuario = 0
		@player2.id_usuario2 = 0
		@player2.id_tournament = 0
		@player2.save

		@add = Player.find(:first, :conditions => ["(id_usuario2=? AND id_tournament=?) OR id=?", current_user.id, @tournament.id, @player2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@tournament.id_usuario)
			@add2="uno"
			if current_user.id==@tournament.id_usuario
				@add2="dos"
			end
		else
			if @tournament.visible == "public" || @tournament.visible == "publico"
				@add2="uno"
			else
				@add2="tres"
			end
		end
		@player2.destroy 
	end


	def versus
		if cookies[:langu]== "en"
			@information = "Information"
			@play = "Players"
			@vs = "Games"
			@classi = "Classification"
			@round = "Round"
			@user1 = "Black"
			@user2 = "White"
			@result = "Result"
		else
			@information = "Datos"
			@play = "Jugadores"
			@vs = "Encuentros"
			@classi = "Clasificacion"
			@round = "Ronda"
			@user1 = "Blancas"
			@user2 = "Negras"
			@result = "Resultado"
		end
		@tournament = Tournament.find(cookies[:last_tournament_id])
		@title = @tournament.name
		@player2 = Player.new(0)
		@player2.id_usuario = 0
		@player2.id_usuario2 = 0
		@player2.id_tournament = 0
		@player2.score = 0
		@player2.save

		@add = Player.find(:first, :conditions => ["(id_usuario2=? AND id_tournament=?) OR id=?", current_user.id, @tournament.id, @player2.id])

		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@tournament.id_usuario)
			@add2="uno"
			if current_user.id==@tournament.id_usuario
				@add2="dos"
			end
		else
			if @tournament.visible == "public" || @tournament.visible == "publico"
				@add2="uno"
			else
				@add2="tres"
			end
		end

		@coon=Player.count(:all, :conditions => ["id_tournament=?", @tournament.id])
		@rounds=@tournament.number_rounds
		@coom1=@tournament.number_players/2
		@coom2=@tournament.number_players/2
		@coom3=@tournament.number_players
		@coom5=@tournament.number_players
		@coom4=0
		@cont=2
		@cont2=1
		@cont3=1
		@cont4=1
		@cont5=	@tournament.number_players-1
		@reff=Battle.count(:all, :conditions => ["id_tournament=?", @tournament.id])
		@cont= (@reff/(@coom3/2))+1
		@contar= 1
		@battle2 = Battle.new(0)
		@battle2.id_tournament = 0
		@battle2.save

if (@tournament.kind == "League" || @tournament.kind == "Liga")
	if (@coon == @tournament.number_players)
			while (@coom5 != 1)
				@cooo=Player.find(:first, :conditions => ["(id_tournament=? AND control=?) OR id=?", @tournament.id, @contar-1, @player2.id])
				if (@cooo.id != @player2.id)
					@cooo.update_attribute(:control, @contar)
					@cooo.update_attribute(:control2, 1000*@rounds+100*@coom5)
					@cont6=@coom5
					@cont5=	@tournament.number_players
					while(@cont5 != @coom5)
						@cuuu=Player.find(:first, :conditions => ["id_tournament=? AND control2!=?", @tournament.id, 1000*@rounds+100*@coom5])
						@cuuu.update_attribute(:control2, 1000*@rounds+100*@coom5)
						@cont5=@cont5-1
					end
					while (@cont6 != 1)
@cuuu=Player.find(:first, :conditions => ["id_tournament=? AND control2!=?", @tournament.id, 1000*@rounds+100*@coom5])
@cuuu.update_attribute(:control2, 1000*@rounds+100*@coom5)
						@table1 = Battle.new
						@table1.round = @contar
						@table1.result = 4
						@table1.id_tournament = cookies[:last_tournament_id]
if @cont6%2==0 && @coom5!=2
						@table1.id_usuario1 = @cooo.id_usuario
						@table1.id_usuario2 = @cooo.id_usuario2
						@table1.id_usuario3 = @cuuu.id_usuario
						@table1.id_usuario4 = @cuuu.id_usuario2
						@table1.save
else
						@table1.id_usuario1 = @cuuu.id_usuario
						@table1.id_usuario2 = @cuuu.id_usuario2
						@table1.id_usuario3 = @cooo.id_usuario
						@table1.id_usuario4 = @cooo.id_usuario2
						@table1.save
end
						@cont6=@cont6-1
					end

				end
				@coom5=@coom5-1
				if @coom5==1
				@cooo=Player.find(:first, :conditions => ["(id_tournament=? AND control=?) OR id=?", @tournament.id, @contar-1, @player2.id])
				@cooo.update_attribute(:control, @contar)
				end
			end
	end

	@player2.destroy
	@battle2.destroy
else
		if (@coon == @tournament.number_players)
			while (@coom1 != 0)
				@cooo=Player.find(:first, :conditions => ["(id_tournament=? AND control=?) OR id=?", @tournament.id, 0, @player2.id])
				if (@cooo.id == @player2.id)
					@pp2 ="el 2"
				else
					@pp3 ="el 3"
				   @table1 = Battle.new
				   @table1.round = 1
				   @table1.result = 4
				   @table1.id_tournament = cookies[:last_tournament_id]
				   @table1.id_usuario1 = @cooo.id_usuario
				   @table1.id_usuario2 = @cooo.id_usuario2
			           @cooo.update_attribute(:control, 1)

				   @cooo=Player.find(:first, :conditions => ["id_tournament=? AND control=?", @tournament.id, 0])
				   @table1.id_usuario3 = @cooo.id_usuario
				   @table1.id_usuario4 = @cooo.id_usuario2
				   @table1.save
				   @cooo.update_attribute(:control, 1)
				end
				@coom1 = @coom1-1
			end

			if(@cont<=@rounds)
			if (@cooo.id == @player2.id)
@coou=Battle.find(:first, :conditions => ["(id_tournament=? AND round=? AND result=?) OR id=?", @tournament.id, @cont-1, 4, @battle2.id])
				if (@coou.id != @battle2.id)
					@pp4 ="El 4"
				else
					while (@coom2 != 0)
@cuuu=Player.find(:first, :conditions => ["(id_tournament=? AND control=?) OR id=?", @tournament.id, @cont-1, @player2.id], :order => 'score desc')
						if (@cuuu.id == @player2.id)
							@pp5 ="el 5"
						else
							@pp6 ="el 6"
							@table1 = Battle.new
							@table1.round = @cont
			   				@table1.result = 4
							@table1.id_tournament = cookies[:last_tournament_id]
							@table1.id_usuario1 = @cuuu.id_usuario
							@table1.id_usuario2 = @cuuu.id_usuario2
							@cuuu.update_attribute(:control, @cont)

@cuou=Player.find(:first, :conditions => ["(id_tournament=? AND control=? AND control2!=?) OR id=?", @tournament.id, @cont-1, @cont*100+@cont3, @player2.id], :order => 'score desc')
@cuouu=Battle.find(:first, :conditions => ["(id_tournament=? AND ((id_usuario2=? AND id_usuario4=?)OR(id_usuario2=? AND id_usuario4=?))) OR id=?", @tournament.id, @cuuu.id_usuario2, @cuou.id_usuario2, @cuou.id_usuario2, @cuuu.id_usuario2, @battle2.id])

							while (@coom4==0)
								@pp7 ="el 7"
								if(@coom3-@cont4==@cont3)
									@pp11 ="el 11"
									@table1.id_usuario3 = @cuou.id_usuario
									@table1.id_usuario4 = @cuou.id_usuario2
									@table1.save
									@cuou.update_attribute(:control, @cont)
									@coom4=1
								else
									if (@cuouu.id != @battle2.id)
										@pp8 ="el 8"
										@cuou.update_attribute(:control2, @cont*100+@cont3) 
									else
										@pp9 ="el 9"
										@table1.id_usuario3 = @cuou.id_usuario
										@table1.id_usuario4 = @cuou.id_usuario2
										@table1.save
										@cuou.update_attribute(:control, @cont)
										@coom4=1
									end
								end
@cuou=Player.find(:first, :conditions => ["(id_tournament=? AND control=? AND control2!=?) OR id=?", @tournament.id, @cont-1, @cont*100+@cont3, @player2.id], :order => 'score desc')
@cuouu=Battle.find(:first, :conditions => ["(id_tournament=? AND ((id_usuario2=? AND id_usuario4=?)OR(id_usuario2=? AND id_usuario4=?))) OR id=?", @tournament.id, @cuuu.id_usuario2, @cuou.id_usuario2, @cuou.id_usuario2, @cuuu.id_usuario2, @battle2.id])
								@cont3 = @cont3+1
							end
							@coom4=0
							@cont3=1
						end
						@cont4 = @cont4+2
						@coom2 = @coom2-1
					end
				end
			end
			else
				@pp14="el 14"
			end
		end
		@player2.destroy
		@battle2.destroy
end

	@battlesend = Battle.paginate(:page => params[:page],:conditions => ["id_tournament=?", @tournament.id], :order => 'created_at ASC', :per_page => 20 ) 
	end



	def classification
		if cookies[:langu]== "en"
			@information = "Information"
			@play = "Players"
			@vs = "Games"
			@classi = "Classification"
		else
			@information = "Datos"
			@play = "Jugadores"
			@vs = "Encuentros"
			@classi = "Clasificacion"
		end
		@tournament = Tournament.find(cookies[:last_tournament_id])
		@title = @tournament.name
		@playerdd = Player.paginate(:page => params[:page], :per_page => 6, :conditions => ["id_tournament=?", @tournament.id], :order => 'score DESC')

		@player2 = Player.new(0)
		@player2.id_usuario = 0
		@player2.id_usuario2 = 0
		@player2.id_tournament = 0
		@player2.save

		@add = Player.find(:first, :conditions => ["(id_usuario2=? AND id_tournament=?) OR id=?", current_user.id, @tournament.id, @player2.id])


		if (current_user.admin? || @add.id_usuario2==current_user.id || current_user.id==@tournament.id_usuario)
			@add2="uno"
			if current_user.id==@tournament.id_usuario
				@add2="dos"
			end
		else
			if @tournament.visible == "public" || @tournament.visible == "publico"
				@add2="uno"
			else
				@add2="tres"
			end
		end
		@player2.destroy
	end



	def new
		@tournament = Tournament.new
		if cookies[:langu]== "en"
			@title = "New Tournament"
			@msgg = "Registry tournament"
		else
			@title = "Nuevo Torneo"
			@msgg = "Registro de Torneo"
		end
	end
  

	def create
		@tournament = Tournament.new(params[:tournament])
		@tournament.id_usuario = current_user.id
		if cookies[:langu]== "en"
			if @tournament.save
				flash[:success] = "Tournament registered"
				redirect_to @tournament
			else
				@title = "Sign up"
				render 'new'
			end
		else
			if @tournament.save
				flash[:success] = "Torneo Registrado"
				redirect_to @tournament
			else
				@title = "Registro"
				render 'new'
			end
		end
	end

  
	def edit
		@tournament = Tournament.find(params[:id])
	end
  

	def update
		@tournament = Tournament.find(params[:id])
		if cookies[:langu]== "en"
			if @tournament.update_attributes(params[:tournament])
			  flash[:success] = "Tournament upgraded."
			  redirect_to @tournament
			else
			  @title = "Edit Tournament"
			  render 'edit'
			end
		else
			if @tournament.update_attributes(params[:tournament])
			  flash[:success] = "Torneo Actualizado"
			  redirect_to @tournament
			else
			  @title = "Editar Torneo"
			  render 'edit'
			end
		end
	end
  
	def destroy
		@tournament = Tournament.find(params[:id])
		@tournament.destroy
		if cookies[:langu]== "en"
			flash[:success] = "Tournament destroyed"
		else
			flash[:success] = "Torneo Destruido"
		end
		redirect_to tournaments_path
	end


	private

		def authenticate
		  deny_access unless signed_in?
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

		def correct_user2
			@tournament = Tournament.find(cookies[:last_tournament_id])
			@user = User.find(id=@tournament.id_usuario) 
			redirect_to(tournaments_path) unless current_user?(@user) unless current_user.admin?
		end


end
