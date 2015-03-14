class Api::V1::Subject::SubjectController < Api::ApiController
  before_action :authenticate

  def show
    subject_manager = Api::V1::Subjects::SubjectManager.new
    render subject_manager.show_subject params[:id]
  end

  def new
    subject_manager = Api::V1::Subjects::SubjectManager.new
    render subject_manager.create_subject(params[:app_id], params[:external_id],
                                      params[:external_email], params[:external_first_name],
                                      params[:external_last_name], params[:is_active])
  end


  def ranking
    subject_manager = Api::V1::Subjects::SubjectManager.new

    if params[:page].nil?
      page = 1
    else
      page = params[:page]
    end
    if params[:limit].nil?
      limit = 10
    else
      limit = params[:limit]
    end

    render subject_manager.subject_ranking(params[:id], page, limit)
  end

end
