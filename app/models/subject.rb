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
  has_many :activity_logs, :class_name => "ActivityLog"
  
  def name
    "#{external_first_name} #{external_last_name}"
  end

  def points
    current_points = 0

    event_logs.each do |log|
      unless log.event.nil?
        current_points += log.event.value
      end  
    end 

    current_points 
  end  

end  