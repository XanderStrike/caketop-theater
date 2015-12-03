# frozen_string_literal: true
# Whenever is awesome, thanks javan: http://github.com/javan/whenever

# Use this file to set how often you want your scans to be.
# You can use minutes, hours, days, weeks, months, and years

every 15.minutes do
  rake 'scan:movies'
end

every 1.hour do
  rake 'scan:tv'
end

every 1.day do
  rake 'scan:music'
end

every :wednesday do
  rake 'convert:movies'
end

every :monday do
  rake 'convert:tv'
end

# Uncomment this line to save a log somewhere
set :output, '/srv/theater/log/scans.log'
