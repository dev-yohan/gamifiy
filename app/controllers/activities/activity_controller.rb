class Activities::ActivityController < ApplicationController
 before_filter :authenticate_user!


  def index
    
    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @activities = Activity.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)
    
  end

  def show

    @activity = Activity.find(params[:id])
    @activity_logs = ActivityLog.where(:activity => @activity).desc(:date).page(1).per(10)

    @events = Event.where(:activity => @activity)


  end  

  def behavior_data

    date_fetcher = DateFetcher.new
    activity_fetcher = ActivityFetcher.new
    @activity = Activity.find(params[:id])

    behavior_array = activity_fetcher.get_hourly_behavior_data(date_fetcher.get_hourly_array(86400, 0, Date.today.to_time.to_i), @activity)

    render json: behavior_array

  end  

  def weekly_behavior_data

    date_fetcher = DateFetcher.new
    activity_fetcher = ActivityFetcher.new
    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @activities = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)

    behavior_array = activity_fetcher.get_daily_behavior_data(date_fetcher.get_daily_array(604800, 1, Date.today.at_beginning_of_week.to_time.to_i), @activities)

    render json: behavior_array

  end  

end