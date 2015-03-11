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

end
