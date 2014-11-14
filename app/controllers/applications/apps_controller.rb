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

  def create

    @app = Sites::Site.new

  end  

  def new

      @app = Sites::Site.new()
      @app.name = params[:app_data][:name]
      @app.description = params[:app_data][:description]
      @app.logo = params[:app_data][:logo]
      @app.user = current_user
      @app.save

      redirect_to applications_list_path

  end  
 

end