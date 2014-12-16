class Events::EventController < ApplicationController
  before_filter :authenticate_user!

  def index

    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    activity_ids = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)
    @events = Event.where(:activity_id.in => activity_ids).desc(:created_at).page(params[:page]).per(page_size)

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

end 