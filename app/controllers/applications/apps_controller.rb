class Applications::AppsController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    page_size = 10

    @user_sites = Sites::Site.where(:user => current_user).page(params[:page]).per(page_size)
    
  end 

  def show

    page_size = 10 

    @app = Sites::Site.find(params[:id])
    @activities = Activity.where(:site => @app).page(params[:page]).per(page_size)

  end  
 

end