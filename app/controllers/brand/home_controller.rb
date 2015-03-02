class Brand::HomeController < ApplicationController

  layout "brand"

  def index
    @plans = Business::Plan.all
  end


end
