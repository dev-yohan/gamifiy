class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :value, type: Integer
  field :count, type: Integer

  belongs_to :badge, :class_name => "Badge"
  belongs_to :activity, :class_name => "Activity"
  has_many :event_logs, :class_name => "EventLog"

  field :event_logs_count, type: Integer


end
