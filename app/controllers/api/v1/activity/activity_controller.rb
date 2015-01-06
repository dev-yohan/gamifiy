class Api::V1::Activity::ActivityController < Api::ApiController
  before_action :authenticate

  def show
    activity_manager = Api::V1::Activities::ActivityManager.new
    render activity_manager.show_activity params[:id]
  end  

end  