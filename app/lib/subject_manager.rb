class SubjectManager

  def self.get_badges(subject, page, limit)
    badges = Array.new
    unless subject.event_logs.nil?
      subject.event_logs.desc(:created_at).each do |log|
        badges << log.event.badge
      end 
    end
    badges  
  end  

  def self.get_activity_logs(subject, page, limit)
    activity_logs = Array.new
    unless subject.activity_logs.nil?
      subject.activity_logs.desc(:created_at).each do |log|
        activity_logs << log
      end 
    end
    activity_logs  
  end

  def self.get_event_logs(subject, page, limit)
    event_logs = Array.new
    unless subject.event_logs.nil?
      subject.event_logs.desc(:created_at).each do |log|
        event_logs << log
      end 
    end
    event_logs  
  end    

end  