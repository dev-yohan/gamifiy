class Api::V1::Events::EventManager

  def show_event(event_id)
    begin
      activity = ::Activity.find(activity_id)

      if !activity.site.nil?
        site = {id: activity.site.id, name: activity.site.name}
      else
        site = {}
      end
        
      json_data = {id: activity._id,
                        name: activity.name,
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

  #event by activity
  def events_by_activity(activity_id)
    json_data = Array.new

    begin
      activity = ::Activity.find(activity_id)
      events = ::Event.where(activity: activity)
      
      events.each do |event|

        if !event.badge.nil?
          badge_info = {id: event.badge._id, name: event.badge.name}  
        else
          badge_info = {}
        end  

        json_data.push({id: event._id,
                        name: event.name,
                        value: event.value,
                        count:  event.count,
                        badge: badge_info})
      end  

      status = 200

    rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 201,
         dev_message: I18n.t("activities.api.error.code_201.dev_message", id: activity_id), 
         friendly_message: I18n.t("activities.api.error.code_201.friendly_message", id: activity_id)}
        status = 404
    end

    return {json: json_data, status: status}   
  end  

end  