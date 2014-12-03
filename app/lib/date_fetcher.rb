class DateFetcher


  def get_hourly_array(timespan, start_hour, start_timestamp)
    
    hours_array = Array.new
    
    hours = (timespan/3600).ceil + 1
    
    i = 1
    current_hour = start_hour
    current_timestamp = start_timestamp
    
    while i < hours
      
      if current_hour > 23
        current_hour = 0
        hours_array.push({:index => current_hour,
           :timestamp => current_timestamp, 
           :datetime => Time.at(current_timestamp), 
           :time_unit => Time.at(current_timestamp).strftime("%H"), 
           :friendly_date => Time.at(current_timestamp).strftime("%Y-%m-%d %H:%M"), 
          :day_of_week => Time.at(current_timestamp).strftime("%u"),
          :hour_of_day => Time.at(current_timestamp).strftime("%k")})
      else
        hours_array.push({:index => current_hour, 
          :timestamp => current_timestamp, 
          :datetime => Time.at(current_timestamp),  
          :time_unit => Time.at(current_timestamp).strftime("%H"), 
          :friendly_date => Time.at(current_timestamp).strftime("%Y-%m-%d %H:%M"), 
          :day_of_week => Time.at(current_timestamp).strftime("%u"),
          :hour_of_day => Time.at(current_timestamp).strftime("%k")})
      end  
      current_hour = current_hour + 1  
      current_timestamp = current_timestamp + 3600
      i = i + 1
    end   
    
    return hours_array
    
  end

  def get_daily_array(timespan, start_day, start_timestamp)
    
    days_array = Array.new
    
    days = (timespan/86400).ceil + 1
    
    i = 1
    current_day = start_day
    current_timestamp = start_timestamp
    
    while i < days
      
      if current_day > 7
        current_day = 1
        days_array.push({:index => current_day,
           :timestamp => current_timestamp, 
           :datetime => Time.at(current_timestamp), 
           :time_unit => Time.at(current_timestamp).strftime("%H"), 
           :friendly_date => Time.at(current_timestamp).strftime("%Y-%m-%d %H:%M"), 
          :day_of_week => Time.at(current_timestamp).strftime("%u"),
          :hour_of_day => Time.at(current_timestamp).strftime("%k")})
      else
        days_array.push({:index => current_day, 
          :timestamp => current_timestamp, 
          :datetime => Time.at(current_timestamp),  
          :time_unit => Time.at(current_timestamp).strftime("%H"), 
          :friendly_date => Time.at(current_timestamp).strftime("%Y-%m-%d %H:%M"), 
          :day_of_week => Time.at(current_timestamp).strftime("%u"),
          :hour_of_day => Time.at(current_timestamp).strftime("%k")})
      end  
      current_day = current_day + 1  
      current_timestamp = current_timestamp + 86400
      i = i + 1
    end   
    
    return days_array
    
  end



end  