class HomeController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    sites = Sites::Site.where(:user => current_user)
    @user_sites = sites.count

    activity_page_size = 10
 
    @user_activities = Activity.where(:site_id.in => sites.only(:_id).map(&:_id)).count
    @user_badges = Badge.where(:site_id.in => sites.only(:_id).map(&:_id)).count
    @user_subjects = Subject.where(:site_id.in => sites.only(:_id).map(&:_id)).count

    user_page_size = 10
    @activities = Activity.where(:site_id.in => sites.only(:_id).map(&:_id)).desc(:activity_logs_count).page(1).per(activity_page_size)
    @activities_count = ActivityLog.where(:activity_id.in => @activities.only(:_id).map(&:_id)).count.to_f

  end 
 

end