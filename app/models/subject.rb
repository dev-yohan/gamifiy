class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :external_id, type: String
  field :external_email, type: String
  field :external_first_name, type: String
  field :external_last_name, type: String
  field :is_active, type: Boolean

  belongs_to :site, :class_name => "Sites::Site"
  has_many :event_logs, :class_name => "EventLog"
  
  def name
    "#{external_first_name} #{external_last_name}"
  end

end  