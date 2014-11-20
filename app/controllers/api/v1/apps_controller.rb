class Api::V1::AppsController < Api::ApiController
  before_action :authenticate

  def index

      render json: {:hola => "mundo"}

  end  

end
