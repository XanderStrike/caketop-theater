FactoryGirl.define do
  factory :encode do
    a_bitrate '192 kbps'
    a_format 'Advanced Audio Codec'
    a_stream_size '189 MiB (9%)'
    aspect_ratio '2.40:1'
    container 'MPEG-4'
    duration '2h 14mn'
    framerate '23.976 fps'
    resolution '1280'
    rip_date "#{Time.now}"
    size '2210466750'
    v_bitrate '2,000 kbps'
    v_codec 'avc1'
    v_format 'AVC'
    v_profile 'High@L3.1'
    v_stream_size '1.87 GiB (91%)'
    sequence(:filename) { |n| "Movie #{n}.2013.720p.BR-Rip.mp4" }

    movie
  end
end
