#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the books view and the database through book model.
#-------------------------------------------------------------------------------------------------------

class BooksController < ApplicationController
	before_filter :authenticate, :only => [:show, :edit, :update, :destroy, :new, :index, :search, :searchall]
	before_filter :correct_user, :only => [:edit, :update, :destroy]

	def index
		@books = Book.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 20 ) 
		if cookies[:langu]== "en"
			@title = "Games"
			@of = "of"
			@msg = "Share your work with the rest of the world."
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
			@title = "Partidas"
			@of = "de"
			@msg = "Comparte tu obra con el resto del mundo."
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


	def show
		@book = Book.find(params[:id])
		@user_book = User.find(id=@book.id_usuario)
		@title = @book.event
		@micropost = Micropost.new
		cookies[:last_book_id] = @book.id 
		@micropostss = Micropost.paginate(:page => params[:page], :per_page => 8, :conditions => ["id_book=?", params[:id]], :order => 'created_at DESC' )
		if cookies[:langu]== "en"
			@msg = "Comments"
			@event = "Event"
			@site = "Site"
			@round = "Round"
			@white = "Player White"
			@black = "Player Black"
			@eco = "Eco"
			@date = "Date"
			@result = "Result"
			@user = "User"
			@upd = "Uploaded"
			@down = "Download"
			@edit = "Edit PGN"
			@day = "day"
		else
			@msg = "Comentarios"
			@event = "Evento"
			@site = "Lugar"
			@round = "Ronda"
			@white = "Jugador Blancas"
			@black = "Jugador Negras"
			@eco = "Eco"
			@date = "Fecha"
			@result = "Resultado"
			@user = "Usuario"
			@upd = "Subido"
			@down = "Descargar"
			@edit = "Editar PGN"
			@day = "dia"
		end
	end

	
	def event
		@letter = params[:letter].blank? ? 'a' : params[:letter]
		if params[:letter] == '#'
			@data = Book.find(:all, :conditions => ["event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ?",
			  "0%","1%","2%","3%","4%","5%","6%","7%","8%","9%"], :order => 'event')
		else
			@data = Book.find(:all, :conditions => ["event LIKE ?",
			  "#{params[:letter]}%"], :order => 'event ASC')
		end
		if cookies[:langu]== "en"
			@title = "Gallery"
			@msg = "Share your work with the rest of the world."
			@news = "NEWS"
			@event = "EVENT"
			@site = "SITE"
			@date = "DATE"
			@register = "New PGN"
		else
			@title = "Galeria"
			@msg = "Comparte tu obra con el resto del mundo."
			@news = "NOVEDADES"
			@event = "EVENTO"
			@site = "LUGAR"
			@date = "FECHA"
			@register = "Nuevo PGN"
		end
	end	
	

	def site
		@letter = params[:letter].blank? ? 'a' : params[:letter]
		if params[:letter] == '#'
		  @data = Book.find(:all, :conditions => ["site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ?",
			  "0%","1%","2%","3%","4%","5%","6%","7%","8%","9%"], :order => 'site')
		else
		  @data = Book.find(:all, :conditions => ["site LIKE ?",
			  "#{params[:letter]}%"], :order => 'site ASC')
		end
		if cookies[:langu]== "en"
			@title = "Gallery"
			@msg = "Share your work with the rest of the world."
			@news = "NEWS"
			@event = "EVENT"
			@site = "SITE"
			@date = "DATE"
			@register = "New PGN"
		else
			@title = "Galeria"
			@msg = "Comparte tu obra con el resto del mundo."
			@news = "NOVEDADES"
			@event = "EVENTO"
			@site = "LUGAR"
			@date = "FECHA"
			@register = "Nuevo PGN"
		end
	end	

	def date
		@books = Book.paginate(:page => params[:page], :order => 'date DESC', :per_page => 20 ) 
		if cookies[:langu]== "en"
			@title = "Gallery"
			@msg = "Share your work with the rest of the world."
			@news = "NEWS"
			@event = "EVENT"
			@site = "SITE"
			@date = "DATE"
			@register = "New PGN"
		else
			@title = "Galeria"
			@msg = "Comparte tu obra con el resto del mundo."
			@news = "NOVEDADES"
			@event = "EVENTO"
			@site = "LUGAR"
			@date = "FECHA"
			@register = "Nuevo PGN"
		end
	end



	def searchall
		searchv = params[:name].blank? ? "%" : "%" + params[:name] + "%"
		search0 =  "%" + searchv + "%"
		search1 =  "%" + searchv.downcase + "%"
		search2 =  "%" + searchv.upcase + "%"
		search3 =  "%" + searchv.capitalize + "%"
		search4 =  "%" + searchv.titleize + "%"
		@busca = Book.find(:all, :conditions => ['event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ?' ,search0, search1, search2, search3, search4, search0, search1, search2, search3, search4])
		if cookies[:langu]== "en"
			@title = "Search"
			@msg = "Perform an advanced search through the form."
			@result = "Search result"
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
			@title = "Busqueda"
			@msg = "Utiliza nuestro buscador avanzado para examinar nuestro contenido."
			@result = "Resultado"
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


	def search
		asearchv = params[:event].blank? ? "%" : "%" + params[:event] + "%"
		asearch0 =  "%" + asearchv + "%"
		asearch1 =  "%" + asearchv.downcase + "%"
		asearch2 =  "%" + asearchv.upcase + "%"
		asearch3 =  "%" + asearchv.capitalize + "%"
		asearch4 =  "%" + asearchv.titleize + "%"
		bsearchv = params[:site].blank? ? "%" : "%" + params[:site] + "%"
		bsearch0 =  "%" + bsearchv + "%"
		bsearch1 =  "%" + bsearchv.downcase + "%"
		bsearch2 =  "%" + bsearchv.upcase + "%"
		bsearch3 =  "%" + bsearchv.capitalize + "%"
		bsearch4 =  "%" + bsearchv.titleize + "%"
		csearchv = params[:black].blank? ? "%" : "%" + params[:black] + "%"
		csearch0 =  "%" + csearchv + "%"
		csearch1 =  "%" + csearchv.downcase + "%"
		csearch2 =  "%" + csearchv.upcase + "%"
		csearch3 =  "%" + csearchv.capitalize + "%"
		csearch4 =  "%" + csearchv.titleize + "%"
		dsearchv = params[:elo_black].blank? ? "%" : "%" + params[:elo_black] + "%"
		esearchv = params[:white].blank? ? "%" : "%" + params[:white] + "%"
		esearch0 =  "%" + esearchv + "%"
		esearch1 =  "%" + esearchv.downcase + "%"
		esearch2 =  "%" + esearchv.upcase + "%"
		esearch3 =  "%" + esearchv.capitalize + "%"
		esearch4 =  "%" + esearchv.titleize + "%"
		fsearchv = params[:elo_white].blank? ? "%" : "%" + params[:elo_white] + "%"
		gsearchv = params[:round].blank? ? "%" : "%" + params[:round] + "%"
		hsearchv = params[:result].blank? ? "%" : "%" + params[:result] + "%"


		@buscaa = Book.find(:all, :conditions => ['(event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ? OR event LIKE ?)AND(site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ? OR site LIKE ?)AND(black LIKE ? OR black LIKE ? OR black LIKE ? OR black LIKE ? OR black LIKE ?)AND(white LIKE ? OR white LIKE ? OR white LIKE ? OR white LIKE ? OR white LIKE ?)AND(result LIKE ?)' ,asearch0, asearch1, asearch2, asearch3, asearch4,bsearch0, bsearch1, bsearch2, bsearch3, bsearch4, csearch0, csearch1, csearch2, csearch3, csearch4, esearch0, esearch1, esearch2, esearch3, esearch4, hsearchv])

		if cookies[:langu]== "en"
			@title = "Search"
			@msg = "Perform an advanced search through the form."
			@result = "Search result"
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
			@title = "Busqueda"
			@msg = "Utiliza nuestro buscador avanzado para examinar nuestro contenido."
			@result = "Resultado"
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
		@book = Book.new
		if cookies[:langu]== "en"
			@title = "New PGN"
		else
			@title = "Nuevo PGN"
		end
	end
  

	def create
		@book = Book.new(params[:book])
		@book.id_usuario = current_user.id
		if cookies[:langu]== "en"
			if @book.save
				flash[:success] = "Book registered"
				redirect_to @book
			else
				@title = "Sign up"
				render 'new'
			end
		else
			if @book.save
				flash[:success] = "Libro Registrado"
				redirect_to @book
			else
				@title = "Registro"
				render 'new'
			end
		end
	end

  
	def edit
		@book = Book.find(params[:id])
		@user_book = User.find(id=@book.id_usuario)
		if cookies[:langu]== "en"
			@title = "Edit Book"
			@author = "Author"
			@topic = "Topic"
			@idiom = "Idiom"
			@date = "Date"
			@user = "User"
			@upd = "Uploaded"
			@down = "Download"
			@edit = "Edit book"
			@day = "day"
		else
			@title = "Editar Libro"
			@author = "Autor"
			@topic = "Tema"
			@idiom = "Idioma"
			@date = "Fecha"
			@user = "Usuario"
			@upd = "Subido"
			@down = "Descargar"
			@edit = "Editar Libro"
			@day = "dia"
		end
	end
  

	def update
		@book = Book.find(params[:id])
		@book.remove_attachment!
		if cookies[:langu]== "en"
			if @book.update_attributes(params[:book])
			  flash[:success] = "Book upgraded."
			  redirect_to @book
			else
			  @title = "Edit Book"
			  render 'edit'
			end
		else
			if @book.update_attributes(params[:book])
			  flash[:success] = "Libro Actualizado"
			  redirect_to @book
			else
			  @title = "Editar Libro"
			  render 'edit'
			end
		end
	end
  
	def destroy
		@book = Book.find(params[:id])
		@book.remove_attachment!
		@book.destroy
		if cookies[:langu]== "en"
			flash[:success] = "Book destroyed"
		else
			flash[:success] = "Libro Destruido"
		end
		redirect_to books_path
	end

	
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

		def correct_user
		  @book = Book.find(params[:id])
		  @user = User.find(id=@book.id_usuario) 
		  redirect_to(books_path) unless current_user?(@user) unless current_user.admin?
		end

end
