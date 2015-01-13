class Api::V1::Subjects::SubjectManager

  #show subject by id
  def show_subject(subject_id)
    begin
      subject = ::Subject.find(subject_id)

      if !subject.site.nil?
        site = {id: subject.site.id, name: subject.site.name}
      else
        site = {}
      end

      json_data = {id: subject._id,
        external_id: subject.external_id,
        external_email: subject.external_email,
        is_active: subject.is_active,
        site: site}

      rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 501,
          dev_message: I18n.t("subjects.api.error.code_501.dev_message", id: subject_id),
          friendly_message: I18n.t("subjects.api.error.code_501.friendly_message", id: subject_id)}
          status = 404
        end

        return {json: json_data, status: status}
      end

    end
