class Api::V1::AppsController < Api::ApiController
  before_action :authenticate

  def index

      json_data = Array.new
      site = Sites::Site.where(:access_token => @token).first

      if !site.nil?

        json_data.push({:id => site._id, 
                        :name => site.name, 
                        :slug => site.slugs.first,
                        :description => site.description
                        })
        status = 200

      else

        json_data = {:error_code => 100,
         :dev_message => I18n.t("apps.api.error.code_100.dev_message"), 
         :friendly_message => I18n.t("apps.api.error.code_100.friendly_message")}
        status = 404

      end  

      render json: json_data, :status => status

  end  


  def show

    json_data = Array.new

    begin
      site = Sites::Site.find(params[:id])

      json_data = {:id => site._id, 
                        :name => site.name, 
                        :slug => site.slugs.first,
                        :description => site.description
                  }

    rescue Mongoid::Errors::DocumentNotFound
    
        json_data = {:error_code => 101,
         :dev_message => I18n.t("apps.api.error.code_101.dev_message", :id => params[:id]), 
         :friendly_message => I18n.t("apps.api.error.code_101.friendly_message", :id => params[:id])}
        status = 404
 
    end    

     render json: json_data, :status => status

  end  

end
