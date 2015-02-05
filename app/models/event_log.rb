class EventLog
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  belongs_to :event, :class_name => "Event"
  belongs_to :activity_log, :class_name => "ActivityLog"
  belongs_to :subject, :class_name => "Subject"

  field :date, type: DateTime

end
