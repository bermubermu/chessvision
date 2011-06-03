#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the sessions view.
#-------------------------------------------------------------------------------------------------------

class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
	if cookies[:langu]== "en"
		redirect_to users_path, :notice => "Incorrect data. Re-enter"
	else
		redirect_to users_path, :notice => "Datos incorrectos. Vuelva a introducirlos"
	end
	@title = "Sign in"

    else
      sign_in user
      redirect_back_or user
    end
  end
  
	def destroy
		sign_out
		if cookies[:langu]== "en"
			redirect_to english_path
		else
			redirect_to root_path
		end
	end
end


