#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the pages view.
#-------------------------------------------------------------------------------------------------------

class PagesController < ApplicationController
	def home
		@title = "Inicio"
		cookies[:langu]= "sp"
	end
	def home2
		@title = "Home"
		cookies[:langu]= "en"
	end

	def help
		if cookies[:langu]== "en"
			@title = "Contact"
			@big="View larger map."
		else
			@title = "Contacto"
			@big = "Ver mapa en grande"
		end
	end

	def tablero
		if cookies[:langu]== "en"
			@cargar = "Load PGN"
			@title = "View PGN"

		else
			@cargar = "Cargar PGN"
			@title = "Ver PGN"
		end
	end

	def chat
			@title = "Chat"
	end

	def ia
		if cookies[:langu]== "en"
			@title = "Play"

		else
			@title = "Jugar"
		end
	end
end






