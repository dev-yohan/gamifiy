class Api::V1::Subjects::SubjectManager

  #show subject by id
  def show_subject(subject_id)
    begin
      subject = ::Subject.find(subject_id)

      if !subject.site.nil?
        site = subject.site.id.to_s
      else
        site = {}
      end

      json_data = {id: subject.id.to_s,
        external_id: subject.external_id,
        external_email: subject.external_email,
        external_first_name: subject.external_first_name,
        external_last_name: subject.external_last_name,
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

  #create new subject
  def create_subject(app_id, external_id, external_email, external_first_name, external_last_name, is_active)
    site = ::Sites::Site.where(id: app_id).first

    if !site.nil?

      subject = ::Subject.new()
      subject.external_id = external_id
      subject.external_email = external_email
      subject.external_first_name = external_first_name
      subject.external_last_name = external_last_name
      subject.is_active = is_active

      subject.site = site

      if subject.save
        json_data = {id: subject._id,
          external_id: subject.external_id,
          external_email: subject.external_email,
          is_active: subject.is_active,
          site: site}

          status = 200
      else
        json_data = {error_code: 502,
          dev_message: I18n.t("subjects.api.error.code_502.dev_message"),
          friendly_message: I18n.t("subjects.api.error.code_502.friendly_message")}
          status = 502
      end

    else

      json_data = {:error_code => 100,
       :dev_message => I18n.t("apps.api.error.code_100.dev_message"),
       :friendly_message => I18n.t("apps.api.error.code_100.friendly_message")}
      status = 404

    end

    return {json: json_data, status: status}
  end

end
