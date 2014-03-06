class Encode < ActiveRecord::Base
  attr_accessible :movie_id, :a_bitrate, :a_format, :a_stream_size, :aspect_ratio, :container, :duration, :framerate, :resolution, :rip_date, :size, :v_bitrate, :v_codec, :v_format, :v_profile, :v_stream_size, :filename
end
