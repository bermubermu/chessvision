#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the microposts view and the database through micropost model.
#-------------------------------------------------------------------------------------------------------

class AnswersController < ApplicationController
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
		@problem = Problem.find(params[:id])
	end
  
	def create
		@answer = Answer.new(params[:answer])
		@answer.id_usuario = current_user.name
		@answer.id_usuario2 = current_user.id
		@answer.id_problem = cookies[:last_problem_id]
		@problem = Problem.find(id=@answer.id_problem)

		if cookies[:langu]== "en"
			if @answer.save
				flash[:success] = "Answer reported"
				redirect_to @problem
			else
				@title = "Sign up"
				redirect_to @problem
			end
		else
			if @answer.save
				flash[:success] = "Respuesta Registrada"
				redirect_to @problem
			else
				@title = "Registro"
				redirect_to @problem
			end
		end
	end
	

	def destroy
		@answer = Answer.find(params[:id])
		@problem = Problem.find(id=@answer.id_problem)
		@answer.destroy
		redirect_to @problem
	end
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

end

  
