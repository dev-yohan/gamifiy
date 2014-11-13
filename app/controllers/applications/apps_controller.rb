class Applications::AppsController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    page = 1
    page_size = 10

    @user_sites = Sites::Site.where(:user => current_user).page(page).per(page_size)
    
  end 

  def show

    @app = Sites::Site.find(params[:id])

  end  
 

end