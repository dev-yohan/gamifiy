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
                    image: badge.image.thumbnail.url,
                    site: site}

    rescue Mongoid::Errors::DocumentNotFound
        json_data = {error_code: 401,
         dev_message: I18n.t("badges.api.error.code_401.dev_message", id: badge_id),
         friendly_message: I18n.t("badges.api.error.code_401.friendly_message", id: badge_id)}
        status = 404
    end

    return {json: json_data, status: status}
  end


  ## Show user badges
  def show_badges_by_user(app_id, external_id, page, limit)
    site = ::Sites::Site.where(id: app_id).first

    if !site.nil?
      json_data = Array.new

        subject = ::Subject.where(external_id: external_id).first

        if !subject.nil?

            event_logs = ::EventLog.where(subject: subject).page(page).per(limit)

            badges = ::Badge.where(site: site)

            event_logs.each do |log|

              if log.event.badge.site.id == site.id

                json_data.push({
                  id: log.event.badge.id.to_s,
                  name: log.event.badge.name,
                  slug: log.event.badge.slugs.first,
                  image: log.event.badge.image.thumbnail.url,
                  site: log.event.badge.site.id.to_s,
                  points: log.event.badge.events.first.value
                  })
              end

            end

            status = 200
        else
          json_data = {error_code: 501,
            dev_message: I18n.t("subjects.api.error.code_501.dev_message", id: subject_id),
            friendly_message: I18n.t("subjects.api.error.code_501.friendly_message", id: subject_id)}
            status = 404
        end

    else

      json_data = {:error_code => 100,
       :dev_message => I18n.t("apps.api.error.code_100.dev_message"),
       :friendly_message => I18n.t("apps.api.error.code_100.friendly_message")}
      status = 404

    end

    return {json: json_data, :status => status}

  end

end
