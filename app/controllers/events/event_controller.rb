class Events::EventController < ApplicationController
  before_filter :authenticate_user!

  def index

    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    activity_ids = Activity.where(:site_id.in => sites_ids).only(:_id).map(&:_id)
    @events = Event.where(:activity_id.in => activity_ids).desc(:created_at).page(params[:page]).per(page_size)

  end  

end 