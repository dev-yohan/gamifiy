class Subject
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :external_id, type: String

  has_many :event_by_subject, :class_name => "EventBySubject"
  

end  