class Events::EventController < ApplicationController
  before_filter :authenticate_user!

  def index
    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    activity_ids = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)
    @events = Event.where(:activity_id.in => activity_ids).desc(:created_at).page(params[:page]).per(page_size)
  end

  def show
    begin
      page_size = 20
      @event = Event.find(params[:id])
      @event_logs = EventLog.where(event: @event).desc(:date).page(params[:page]).per(page_size)
    rescue Mongoid::Errors::DocumentNotFound
      redirect_to events_list_path, :flash => {:error => I18n.t("events.api.error.code_300.friendly_message")}
    end
  end

  def create
    @sites = Sites::Site.where(:user => current_user)
    @activities = Activity.where(:site_id.in => @sites.only(:_id).map(&:_id))
    @badges = Badge.where(:site_id.in => @sites.only(:_id).map(&:_id))
    @event = Event.new
  end


  def new
    @event = Event.new()
    @event.name = params[:event_data][:name]
    @event.count = params[:event_data][:count]
    @event.value = params[:event_data][:value]

    activity = Activity.find(params[:activity])
    @event.activity = activity

    badge = Badge.find(params[:badge])
    @event.badge = badge

    if @event.save
      redirect_to events_list_path, :flash => {:success => I18n.t("create_event.save_success")}
    else
      redirect_to event_create_path, :flash => {:error => I18n.t("create_event.save_error")}
    end
  end

  def edit
   @sites = Sites::Site.where(:user => current_user)
   @activities = Activity.where(:site_id.in => @sites.only(:_id).map(&:_id))
   @badges = Badge.where(:site_id.in => @sites.only(:_id).map(&:_id))
   @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.name = params[:event_data][:name]
    @event.count = params[:event_data][:count]
    @event.value = params[:event_data][:value]

    activity = Activity.find(params[:activity])
    @event.activity = activity

    badge = Badge.find(params[:badge])
    @event.badge = badge

    if @event.save
      redirect_to events_list_path, :flash => {:success => I18n.t("edit_event.edit_success")}
    else
      redirect_to event_list_path, :flash => {:error => I18n.t("edit_event.edit_error")}
    end
  end

  def delete
    @event = Event.find(params[:id])
  end

  def destroy
      @event = Event.find(params[:id])
      @app = @event.activity.site

      if @app.user == current_user
          if @event.delete
             redirect_to events_list_path, :flash => {:success => I18n.t("delete_event.delete_success")}
          else
            redirect_to events_list_path, :flash => {:success => I18n.t("delete_event.delete_error")}
          end
      else
        redirect_to events_list_path, :flash => {:success => I18n.t("delete_event.wrong_owner")}
      end
  end

  def weekly_behavior_data
    date_fetcher = DateFetcher.new
    event_fetcher = EventFetcher.new
    if params[:id].nil?
      sites_ids = Sites::Site.where(user: current_user).only(:_id).map(&:_id)
    else
      sites_ids = Sites::Site.where(user: current_user, _id: params[:id]).only(:_id).map(&:_id)
    end

    activities = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)
    @events = Event.where(:activity_id.in => activities).only(:_id).map(&:_id)

    behavior_array = event_fetcher.get_daily_behavior_data(date_fetcher.get_daily_array(604800, 1, Date.today.at_beginning_of_week.to_time.to_i), @events)

    render json: behavior_array
  end

end
