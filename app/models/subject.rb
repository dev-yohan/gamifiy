class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :external_id, type: String
  field :external_email, type: String
  

end  