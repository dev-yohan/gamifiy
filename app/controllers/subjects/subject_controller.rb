class Subjects::SubjectController < ApplicationController
 before_filter :authenticate_user!

  def index
    page_size = 20
    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @users = Subject.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)
  end

  def show
    @subject = Subject.find(params[:id])
    @event_logs = EventLog.where(subject: @subject)
    @badges = SubjectManager.get_badges(@subject, 1, 10)
    @activity_logs = SubjectManager.get_activity_logs(@subject, 1, 10)
    @event_logs = SubjectManager.get_event_logs(@subject, 1, 10)
  end  

  def create
      @sites = Sites::Site.where(:user => current_user)
      @subject = Subject.new
  end

  def new
    @subject = Subject.new()
    @subject.external_id = params[:subject_data][:external_id]
    @subject.external_email = params[:subject_data][:external_email]
    @subject.external_first_name = params[:subject_data][:external_first_name]
    @subject.external_last_name = params[:subject_data][:external_last_name]
    @subject.is_active = params[:subject_data][:is_active]

    site = Sites::Site.find(params[:site])
    @subject.site = site

    if @subject.save
      redirect_to subjects_list_path, :flash => {:success => I18n.t("create_subject.save_success")}
    else
      redirect_to subject_create_path, :flash => {:error => I18n.t("create_subject.save_error")}
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @sites = Sites::Site.where(:user => current_user)
  end

  def update
    @subject = Subject.find(params[:id])

    @subject.external_id = params[:subject_data][:external_id]
    @subject.external_email = params[:subject_data][:external_email]
    @subject.external_first_name = params[:subject_data][:external_first_name]
    @subject.external_last_name = params[:subject_data][:external_last_name]
    @subject.is_active = params[:subject_data][:is_active]

    site = Sites::Site.find(params[:site])
    @subject.site = site

    if @subject.save
      redirect_to subjects_list_path, :flash => {:success => I18n.t("edit_subject.edit_success")}
    else
      redirect_to subjects_list_path, :flash => {:error => I18n.t("edit_subject.edit_error")}
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])

    if @subject.site.user == current_user
      if @subject.delete
         redirect_to subjects_list_path, :flash => {:success => I18n.t("delete_subject.delete_success")}
      else
        redirect_to subjects_list_path, :flash => {:success => I18n.t("delete_subject.delete_error")}
      end
    else
        redirect_to applications_list_path, :flash => {:success => I18n.t("delete_app.wrong_owner")}
    end
  end

end
