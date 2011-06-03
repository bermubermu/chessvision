#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the microposts view and the database through micropost model.
#-------------------------------------------------------------------------------------------------------

class MicropostsController < ApplicationController
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
		@micropost = Micropost.new(params[:micropost])
		@micropost.id_usuario = current_user.name
		@micropost.id_usuario2 = current_user.id
		@micropost.id_book = cookies[:last_book_id]
		@book = Book.find(id=@micropost.id_book)

		if cookies[:langu]== "en"
			if @micropost.save
				flash[:success] = "Post reported"
				redirect_to @book
			else
				@title = "Sign up"
				redirect_to @book
			end
		else
			if @micropost.save
				flash[:success] = "Post Registrado"
				redirect_to @book
			else
				@title = "Registro"
				redirect_to @book
			end
		end
	end
	

	def destroy
		@micropost = Micropost.find(params[:id])
		@book = Book.find(id=@micropost.id_book)
		@micropost.destroy
		redirect_to @book
	end
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

end

  
