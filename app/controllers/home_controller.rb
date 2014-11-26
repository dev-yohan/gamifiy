class HomeController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    sites = Sites::Site.where(:user => current_user)
    @user_sites = sites.count
    @user_activities = Activity.where(:site_id.in => sites.only(:_id).map(&:_id)).count
    @user_badges = Badge.where(:site_id.in => sites.only(:_id).map(&:_id)).count
    @user_subjects = Subject.where(:site_id.in => sites.only(:_id).map(&:_id)).count

  end 
 

end