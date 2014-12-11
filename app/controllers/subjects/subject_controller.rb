class Subjects::SubjectController < ApplicationController
 before_filter :authenticate_user!

  def index

    page_size = 50

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @users = Subject.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)

  end 

  def create

      @sites = Sites::Site.where(:user => current_user)
      @subject = Subject.new

  end 

  def new

    @subject = Subject.new()
    @subject.external_id = params[:subject_data][:external_id]
    @subject.external_email = params[:subject_data][:external_email]
    @subject.is_active = params[:subject_data][:is_active]

    site = Sites::Site.find(params[:site])
    @subject.site = site
   
    if @subject.save
      redirect_to subjects_list_path, :flash => {:success => I18n.t("create_subject.save_success")}
    else
      redirect_to subject_create_path, :flash => {:error => I18n.t("create_subject.save_error")}
    end  

  end  

end 