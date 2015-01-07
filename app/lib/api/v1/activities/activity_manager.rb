class Api::V1::Activities::ActivityManager

  def show_activity(activity_id)
    begin
      activity = ::Activity.find(activity_id)

      if !activity.site.nil?
        site = {id: activity.site.id, name: activity.site.name}
      else
        site = {}
      end
        
      json_data = {id: activity._id,
                        name: activity.name,
                        slug: activity.slugs.first,
                        description: activity.description,
                        is_active:  activity.is_active,
                        activity_logs_count: activity.activity_logs_count,
                        site: site}

    rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 201,
         dev_message: I18n.t("activities.api.error.code_201.dev_message", id: activity_id), 
         friendly_message: I18n.t("activities.api.error.code_201.friendly_message", id: activity_id)}
        status = 404
    end

    return {json: json_data, status: status}     
  end  

end  