class HomeController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    @user_sites = Sites::Site.where(:user => current_user).count
    
  end 
 

end