class EventBySubject
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :subject, :class_name => "Subject"
  belongs_to :event,  :class_name => "Event"
end