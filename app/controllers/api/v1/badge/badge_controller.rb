class Api::V1::Badge::BadgeController < Api::ApiController
  before_action :authenticate

  def show
    badge_manager = Api::V1::Badges::BadgeManager.new
    render badge_manager.show_badge params[:id]
  end  

end  