class Brand::HomeController < ApplicationController

  layout "brand"

  def index
    @plans = Business::Plan.all
    @features = Brand::Feature.where(published: true)
  end


end
