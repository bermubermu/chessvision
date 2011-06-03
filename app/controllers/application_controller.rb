#-------------------------------------------------------------------------------------------------------
# Interacts with the user using the pages view.
#-------------------------------------------------------------------------------------------------------


class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def show
    @user = User.find(current_user)
  end
  
end


