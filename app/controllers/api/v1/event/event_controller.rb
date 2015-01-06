class Api::V1::Activity::ActivityController < Api::ApiController
  before_action :authenticate

  def show
    event_manager = Api::V1::Events::EventManager.new
    render event_manager.events_by_activity params[:id]
  end  

end  