class Badges::BadgeController < ApplicationController
 before_filter :authenticate_user!

  def index
    page_size = 10

    sites_ids = Sites::Site.where(:user => current_user).only(:_id).map(&:_id)
    @badges = Badge.where(:site_id.in => sites_ids).desc(:created_at).page(params[:page]).per(page_size)
  end


  def create
    @sites = Sites::Site.where(:user => current_user)
    @badge = Badge.new
  end
  
  def new
    @badge = Badge.new()
    @badge.name = params[:badge_data][:name]
    @badge.is_active = params[:badge_data][:is_active]
    @badge.image = params[:badge_data][:image]
    site = Sites::Site.find(params[:site])
    @badge.site = site
   
    if @badge.save
      redirect_to badges_list_path, :flash => {:success => I18n.t("create_badge.save_success")}
    else
      redirect_to badge_create_path, :flash => {:error => I18n.t("create_badge.save_error")}
    end  
  end  

  def edit
   @sites = Sites::Site.where(:user => current_user)
   @badge = Badge.find(params[:id])
  end

  def update
    @badge = Badge.find(params[:id])
    @badge.name = params[:badge_data][:name]
    @badge.is_active = params[:badge_data][:is_active]
    @badge.image = params[:badge_data][:image]
    site = Sites::Site.find(params[:site])
    @badge.site = site
   
    if @badge.save
      redirect_to badges_list_path, :flash => {:success => I18n.t("edit_badge.save_success")}
    else
      redirect_to badges_list_path, :flash => {:error => I18n.t("edit_badge.save_error")}
    end  
  end  

end