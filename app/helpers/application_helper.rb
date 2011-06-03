#-------------------------------------------------------------------------------------------------------
# Module to view pages.
#-------------------------------------------------------------------------------------------------------

module ApplicationHelper
	# Devuelve el título de cada página
	def title
		base_title = "ChessVision"
		if @title.nil?
		  base_title
		else
		  "#{base_title} | #{@title}"
		end
	end

	# Imagenes para formulario de acceso usuarios
	def i_usuario
		image_tag("usuario.png", :alt => "usuario")
	end
	def i_home
		image_tag("i_home.png", :alt => "usuario")
	end
	
	def i_v
		image_tag("v.png", :alt => "v")
	end

	def i_contacto
		image_tag("contacto.png", :alt => "v")
	end
	
	def i_telefono
		image_tag("222.png", :alt => "v")
	end
	
	def i_correo
		image_tag("222.png", :alt => "v")
	end
	
	def i_novedades
		image_tag("novedades.png", :alt => "v")
	end
	
	def i_mapa
		image_tag("mapa.png", :alt => "v")
	end
	
	def i_usuarios
		image_tag("usuarios.png", :alt => "v")
	end
	
	def i_perfil
		image_tag("perfil.png", :alt => "v")
	end
	def i_spain
		image_tag("spain.png", :alt => "v")
	end
	def i_england
		image_tag("england.png", :alt => "v")
	end
	def i_play
		image_tag("play.png", :alt => "v")
	end
end
