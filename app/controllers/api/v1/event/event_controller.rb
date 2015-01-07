class Api::V1::Event::EventController < Api::ApiController
  before_action :authenticate

  def show
    event_manager = Api::V1::Events::EventManager.new
    render event_manager.show_event params[:id]
  end  

end  