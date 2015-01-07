class Api::V1::Users::UserManager

  #show user by id
  def show_user(user_id)
    begin
      badge = ::Badge.find(user_id)

      if !badge.site.nil?
        site = {id: badge.site.id, name: badge.site.name}
      else
        site = {}
      end

      json_data = {id: badge._id,
        name: badge.name,
        slug: badge.slugs.first,
        image: badge.image.url,
        site: site}

      rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 501,
          dev_message: I18n.t("subjects.api.error.code_501.dev_message", id: user_id),
          friendly_message: I18n.t("subjects.api.error.code_501.friendly_message", id: user_id)}
          status = 404
        end

        return {json: json_data, status: status}
      end

    end
