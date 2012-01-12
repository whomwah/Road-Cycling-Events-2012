require 'bundler' 
Bundler.require
require 'time'

data = JSON.parse( File.read('data.json') )
cal = RiCal.Calendar do |cal|
  data['events'].each do |e|
    cal.event do |event|
      event.summary     = e['title']
      event.dtstart     = Time.parse(e['start']).getutc
      event.dtend       = Time.parse(e['end']).getutc if e['end']
      event.location    = (e['location'] ? e['location'] : '?') 
      #event.url         = "http://nasa.gov"
    end
  end
end

File.open('cycling_events.ics', 'w') {|f| f.write(cal.to_s) }
