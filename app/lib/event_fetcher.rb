class EventFetcher

  def get_daily_behavior_data(dates_array, events)

    json_data = Array.new


    dates_array.each do |data|

        log_count = EventLog.where(:event_id.in => events,
                               :date.gte => data[:timestamp],
                               :date.lte => (data[:timestamp] + 86400)).count

       json_data.push({:index => data[:index],
                       :timestamp => data[:timestamp],
                       :datetime => data[:datetime],
                       :time_unit => data[:time_unit],
                       :friendly_date => data[:friendly_date],
                       :day_of_week => data[:day_of_week],
                       :hour_of_day => data[:hour_of_day],
                       :log_count => log_count
                       })

    end

    return json_data

  end

end  