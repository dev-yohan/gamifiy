class Api::V1::Activities::ActivityLogManager

  def show_by_activity(activity_id, page, limit)
    begin
      json_data = Array.new
      activity = ::Activity.find(activity_id)
      activity_logs = ::ActivityLog.where(activity: activity).page(page).per(limit)

      activity_logs.each do |log|

        json_data.push({
             id: log.id,
             subject: log.subject.id,
             date: log.date,
             friendly_date: log.date.strftime("%Y-%m-%d %H:%M")
          })

      end

      status = 200

    rescue Mongoid::Errors::DocumentNotFound
      json_data = {error_code: 201,
        dev_message: I18n.t("activities.api.error.code_201.dev_message", id: activity_id),
        friendly_message: I18n.t("activities.api.error.code_201.friendly_message", id: activity_id)}
        status = 404
    end

      {json: json_data, status: status}
  end

end
