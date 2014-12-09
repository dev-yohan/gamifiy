class ActivityLog
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :activity, :class_name => "Activity", :counter_cache => true
  belongs_to :subject, :class_name => "Subject"

  field :date, type: DateTime

end  