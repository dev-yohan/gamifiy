class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :external_id, type: String
  field :external_email, type: String
  
  def name
    external_email
  end

end  