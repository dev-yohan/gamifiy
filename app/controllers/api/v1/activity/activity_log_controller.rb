class Api::V1::Activity::ActivityLogController < Api::ApiController
  before_action :authenticate

  def index
    log_manager = Api::V1::Activities::ActivityLogManager.new
    if params[:page].nil?
      page = 1
    else
      page = params[:page]
    end
    if params[:limit].nil?
      limit = 10
    else
      limit = params[:limit]
    end

    render log_manager.show_by_activity(params[:id], page, limit)
  end

  def new
    log_manager = Api::V1::Activities::ActivityLogManager.new
    render log_manager.create_activity_log(params[:id], params[:external_id])
  end

end
