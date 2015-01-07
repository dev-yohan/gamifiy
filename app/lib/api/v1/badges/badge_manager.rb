class Api::V1::Badges::BadgeManager

  #show badge by id or slug
  def show_badge(badge_id)
    begin
      badge = ::Badge.find(badge_id)

      if !badge.site.nil?
        site = {id: badge.site.id, name: badge.site.name}
      else
        site = {}
      end
        
      json_data = {id: badge._id,
                    name: badge.name,
                    slug: badge.slugs.first,
                    image: badge.image.picture_url
                    site: site}

    rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 401,
         dev_message: I18n.t("badges.api.error.code_401.dev_message", id: badge_id), 
         friendly_message: I18n.t("badges.api.error.code_401.friendly_message", id: badge_id)}
        status = 404
    end

    return {json: json_data, status: status}     
  end

end  