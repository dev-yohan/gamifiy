class Api::ApiController < ActionController::Base
# Authentication and other filters implementation.

   def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @site = Sites::Site.where(access_token: token).first
    end
  end

end
