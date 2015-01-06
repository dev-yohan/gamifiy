class Api::V1::AppActivitiesController < Api::ApiController
  before_action :authenticate

  def index
    json_data = Array.new

    begin
      app = Sites::Site.find(params[:id])
      activities = ::Activity.where(site: app).desc(:activity_logs_count)

      activities.each do |activity|
        json_data.push({:id => activity._id,
                        :name => activity.name,
                        :is_active => activity.is_active,
                        :descrtiption => activity.description,
                        :slug => activity.slugs.first})
      end  

      status = 200

    rescue Mongoid::Errors::DocumentNotFound
        json_data = {:error_code => 101,
         :dev_message => I18n.t("apps.api.error.code_101.dev_message", :id => params[:id]), 
         :friendly_message => I18n.t("apps.api.error.code_101.friendly_message", :id => params[:id])}
        status = 404
    end    

     render json: json_data, :status => status
  end
  

end    