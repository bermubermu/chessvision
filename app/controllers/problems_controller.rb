#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the microposts view and the database through micropost model.
#-------------------------------------------------------------------------------------------------------

class ProblemsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :correct_user, :only => [:edit, :update, :destroy]
	


	def index
		@problems = Problem.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 20 ) 
		if cookies[:langu]== "en"
			@title = "Problems"
			@name = "Name"
			@date = "Date"
			@areyousure = "Will proceed to delete..."
			@nproblem = "New Problem"
			@question = "Problem"
		else
			@title = "Problemas"
			@name = "Nombre"
			@date = "Fecha"
			@areyousure = "Se va a proceder a eliminar..."
			@nproblem = "Nuevo Problema"
			@question = "Problema"
		end
	end

	def show
		@problem = Problem.find(params[:id])
		@title = @problem.name
		@answer = Answer.new
		cookies[:last_problem_id] = @problem.id 
		@answerss = Answer.paginate(:page => params[:page], :per_page => 8, :conditions => ["id_problem=?", params[:id]], :order => 'created_at DESC' )
	end

	def new
		@problem = Problem.new
		if cookies[:langu]== "en"
			@title = "New Problem"
		else
			@title = "Nuevo Problema"
		end
	end

	def create
		@problem = Problem.new(params[:problem])
		@problem.id_usuario = current_user.id
		if cookies[:langu]== "en"
			if @problem.save
				flash[:success] = "Problem registered"
				redirect_to @problem
			else
				@title = "New Problem"
				render 'new'
			end
		else
			if @problem.save
				flash[:success] = "Problema Registrado"
				redirect_to @problem
			else
				@title = "Nuevo Problema"
				render 'new'
			end
		end
	end

	def edit
		@problem = Problem.find(params[:id])
	end



	def update
		@problem = Problem.find(params[:id])

		if cookies[:langu]== "en"
			if @problem.update_attributes(params[:problem])
			  flash[:success] = "Problem upgraded."
			  redirect_to @problem
			else
			  @title = "Edit Problem"
			  render 'edit'
			end
		else
			if @problem.update_attributes(params[:problem])
			  flash[:success] = "Problema Actualizado"
			  redirect_to @problem
			else
			  @title = "Editar Problema"
			  render 'edit'
			end
		end
	end

  

	

	def destroy
		@problem = Problem.find(params[:id])
		@problem.destroy
		if cookies[:langu]== "en"
			flash[:success] = "Problem destroyed"
		else
			flash[:success] = "Problema Destruido"
		end
		redirect_to problems_path
	end
	
	private

		def authenticate
		  deny_access unless signed_in?
		end

	   def correct_user
		@problem = Problem.find(cookies[:last_problem_id])
		@user = User.find(id=@problem.id_usuario) 
		redirect_to(problems_path) unless current_user?(@user) unless current_user.admin?

            end

end

  
