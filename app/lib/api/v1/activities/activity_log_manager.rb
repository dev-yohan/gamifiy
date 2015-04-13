class Api::V1::Activities::ActivityLogManager

  def create_activity_log(activity_id, subject_external_id)
    begin
      json_data = Array.new
      activity = ::Activity.find(activity_id)

      subject = ::Subject.where(external_id: subject_external_id).first

      if !subject.nil?
        activity_log = ::ActivityLog.new(activity: activity, subject: subject, date: DateTime.now)

        if activity_log.save
          json_data = {
               id: activity_log.id,
               subject: activity_log.subject.id,
               date: activity_log.date,
               friendly_date: activity_log.date.strftime("%Y-%m-%d %H:%M")
            }
          status = 200
        else
          json_data = {error_code: 202,
            dev_message: I18n.t("activities.api.error.code_202.dev_message", id: activity_id),
            friendly_message: I18n.t("activities.api.error.code_202.friendly_message", id: activity_id)}
            status = 500
        end

      else
          json_data = {error_code: 501,
             dev_message: I18n.t("subjects.api.error.code_501.dev_message"),
             friendly_message: I18n.t("subjects.api.error.code_501.friendly_message")}
          status = 404
      end
    rescue Mongoid::Errors::DocumentNotFound

      json_data = {error_code: 201,
        dev_message: I18n.t("activities.api.error.code_201.dev_message", id: activity_id),
        friendly_message: I18n.t("activities.api.error.code_201.friendly_message", id: activity_id)}
        status = 404

    end

      {json: json_data, status: status}
  end

  #show activity log by activity
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

  #show activity log by user
  def show_activity_logs_by_user(subject_id, page, limit)
      json_data = Array.new
      begin
          subject = ::Subject.where(external_id: subject_id).first

          activity_logs = ::ActivityLog.where(subject: subject).desc(:date).page(page).per(limit)

          activity_logs.each do |log|

            json_data.push({
                 id: log.id.to_s,
                 subject: log.subject.id.to_s,
                 activity: {id: log.activity.id.to_s, name: log.activity.name},
                 date: log.date,
                 friendly_date: log.date.strftime("%Y-%m-%d %H:%M")
              })

          end

          status = 200

        rescue Mongoid::Errors::DocumentNotFound
          json_data = {error_code: 501,
            dev_message: I18n.t("subjects.api.error.code_501.dev_message", id: subject_id),
            friendly_message: I18n.t("subjects.api.error.code_501.friendly_message", id: subject_id)}
            status = 404
          end

      {json: json_data, status: status}
  end

end
