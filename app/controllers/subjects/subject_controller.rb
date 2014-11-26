class Subjects::SubjectController < ApplicationController
 before_filter :authenticate_user!

def index

  page_size = 50

  sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
  @users = Subject.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)

end 


end 