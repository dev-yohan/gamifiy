class Applications::AppsController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    page_size = 10

    @user_sites = Sites::Site.where(:user => current_user).desc(:created_at).page(params[:page]).per(page_size)
    
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
     
      if @app.save
        redirect_to applications_list_path, :flash => {:success => I18n.t("create_app.save_success")}
      else
        redirect_to applications_list_path, :flash => {:error => I18n.t("create_app.save_error")}
      end  

  end  

  def edit

    @app = Sites::Site.find(params[:id])

  end  

  def update
 
    @app = Sites::Site.find(params[:id])

    if !params[:app_data][:name].nil?
      @app.name = params[:app_data][:name]
    end  
    if !params[:app_data][:description].nil?
      @app.description = params[:app_data][:description]
    end
    if !params[:app_data][:logo].nil?
      @app.logo = params[:app_data][:logo]
        #redirect_to applications_list_path, :flash => {:error => params[:app_data][:logo].inspect}
    end

    if @app.save
      redirect_to applications_list_path, :flash => {:success => I18n.t("edit_app.edit_success")}
    else
      redirect_to applications_list_path, :flash => {:error => I18n.t("edit_app.edit_error")}
    end    

  end

end