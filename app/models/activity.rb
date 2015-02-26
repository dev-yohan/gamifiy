class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug :name

  field :description, type: String
  field :is_active, type: Boolean

  has_many :events, :class_name => "Event"

  belongs_to :site, :class_name => "Sites::Site"
  has_many :activity_logs, :class_name => "ActivityLog"

  field :activity_logs_count, type: Integer

  def name_app
     "#{name} - #{site.name}"
  end  

  before_destroy :destroy_activity_logs, :destroy_events

  def destroy_activity_logs  
    self.activity_logs.destroy
  end

  def destroy_events
     self.events.destroy
  end  

end
