class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :external_id, type: String
  field :external_email, type: String
  field :is_active, type: Boolean

  belongs_to :site, :class_name => "Sites::Site"
  
  def name
    external_email
  end

end  