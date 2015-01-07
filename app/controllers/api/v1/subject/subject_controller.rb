class Api::V1::Subject::SubjectController < Api::ApiController
  before_action :authenticate

  def show
    subject_manager = Api::V1::Subjects::SubjectManager.new
    render subject_manager.show_subject params[:id]
  end

end
