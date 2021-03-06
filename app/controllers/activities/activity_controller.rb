class Activities::ActivityController < ApplicationController
  before_filter :authenticate_user!

  def index
    page_size = 10

    sites_ids = Sites::Site.where(user: current_user).only(:_id).map(&:_id)
    @activities = Activity.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)
  end

  def show
    @activity = Activity.find(params[:id])
    @activity_logs = ActivityLog.where(activity: @activity).desc(:date).page(1).per(10)
    @events = Event.where(activity: @activity)
  end

  def create
    @sites = Sites::Site.where(user: current_user)
    @activity = Activity.new
  end

  def new
    @activity = Activity.new
    @activity.name = params[:activity_data][:name]
    @activity.description = params[:activity_data][:description]
    @activity.is_active = params[:activity_data][:is_active]
    @activity.activity_logs_count = 0
    site = Sites::Site.find(params[:site])
    @activity.site = site
    if @activity.save
      redirect_to activities_list_path, flash: { success: I18n.t('create_activity.save_success') }
    else
      redirect_to activity_create_path, flash: { error: I18n.t('create_activity.save_error') }
    end
  end

  def edit
   @activity = Activity.find(params[:id])
   @sites = Sites::Site.where(user: current_user)
  end

  def update
    @activity = Activity.find(params[:id])

    if !params[:activity_data][:name].nil?
      @activity.name = params[:activity_data][:name]
    end
    if !params[:activity_data][:description].nil?
      @activity.description = params[:activity_data][:description]
    end

    @activity.is_active = params[:activity_data][:is_active]
    site = Sites::Site.find(params[:site])
    @activity.site = site

    if @activity.save
      redirect_to activities_list_path, :flash => {:success => I18n.t("edit_activity.edit_success")}
    else
      redirect_to activities_list_path, :flash => {:error => I18n.t("edit_activity.edit_error")}
    end
  end


  def delete
    @activity = Activity.find(params[:id])
  end

  def destroy
      @activity = Activity.find(params[:id])
      @app = @activity.site

      if @app.user == current_user
          if @activity.destroy
             redirect_to activities_list_path, :flash => {:success => I18n.t("delete_activity.delete_success")}
          else
            redirect_to activities_list_path, :flash => {:success => I18n.t("delete_activity.delete_error")}
          end
      else
        redirect_to activities_list_path, :flash => {:success => I18n.t("delete_activity.wrong_owner")}
      end
  end

  def behavior_data
    date_fetcher = DateFetcher.new
    activity_fetcher = ActivityFetcher.new
    @activity = Activity.find(params[:id])

    behavior_array = activity_fetcher.get_daily_activity_behavior_data(date_fetcher.get_daily_array(604800, 0, Date.today.at_beginning_of_week.to_time.to_i), @activity)

    render json: behavior_array
  end

  def weekly_behavior_data
    date_fetcher = DateFetcher.new
    activity_fetcher = ActivityFetcher.new
    if params[:id].nil?
      sites_ids = Sites::Site.where(user: current_user).only(:_id).map(&:_id)
    else
      sites_ids = Sites::Site.where(user: current_user, _id: params[:id]).only(:_id).map(&:_id)
    end

    @activities = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)

    behavior_array = activity_fetcher.get_daily_behavior_data(date_fetcher.get_daily_array(604800, 0, Date.today.at_beginning_of_week.to_time.to_i), @activities)

    render json: behavior_array
  end
end
