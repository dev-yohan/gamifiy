class Activities::ActivityController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @activities = Activity.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)
    
  end

  def show

    @activity = Activity.find(params[:id])
    @activity_logs = ActivityLog.where(:activity => @activity).desc(:created_at).page(1).per(10)

    @events = Event.where(:activity => @activity)


  end  

  def behavior_data

    date_fetcher = DateFetcher.new
    activity_fetcher = ActivityFetcher.new
    @activity = Activity.find(params[:id])

    behavior_array = activity_fetcher.get_hourly_behavior_data(date_fetcher.get_hourly_array(86400, 0, Date.today.to_time.to_i), @activity)

    render json: behavior_array

  end  

end