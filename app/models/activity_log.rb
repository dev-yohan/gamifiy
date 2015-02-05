class ActivityLog
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps

  after_create :update_log_count, :check_for_events

  belongs_to :activity, :class_name => "Activity"
  belongs_to :subject, :class_name => "Subject"

  field :date, type: DateTime

  def update_log_count
     if self.activity.activity_logs_count.nil? || self.activity.activity_logs_count == 0
       self.activity.activity_logs_count = 1
     else
       self.activity.activity_logs_count = self.activity.activity_logs_count + 1
     end
     self.activity.save
  end

  def check_for_events
    activities_by_user = ActivityLog.where(activity: self.activity, subject: self.subject).count
    event = Event.where(activity: self.activity, count: activities_by_user).first
    if !event.nil?
      event_log = EventLog.new(event: event, activity_log: self, subject: self.subject, date: DateTime.now)
      if event_log.save
        if event.event_logs_count.nil? || event.event_logs_count == 0
          event.event_logs_count =  1
        else
          event.event_logs_count = event.event_logs_count + 1
        end
        event.save
        puts "BADGE EARNED"
      else
        puts "ERROR!!"
      end
    end
  end

end
