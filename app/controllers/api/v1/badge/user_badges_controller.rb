class Api::V1::Badge::UserBadgesController < Api::ApiController
  before_action :authenticate

  def index
    badge_manager = Api::V1::Badges::BadgeManager.new

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

    render badge_manager.show_badges_by_user(params[:app_id], params[:external_id], page, limit)
  end

end
