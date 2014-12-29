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

end 