class Episode
  def initialize(show, season, filename, audio, video)
    @show = show
    @season = season
    @filename = filename

    # true if needs conversion
    @audio = audio
    @video = video
  end

  def to_s
    "#{@filename}: Audio: #{@audio}, Video: #{@video}"
  end

  def convert
  end
end

namespace :convert do
  desc "Converts TV shows that are not in good HTML5 formats"
  task :tv => :environment do

    # Gotta do it folder by folder because we don't keep episode information.
    # Probably a problem.

    puts "Finding episodes that need conversion..."

    shows = `ls public/tv`.split("\n")

    eps_needing_conv = []
    shows.each do |show|
      seasons = `ls "public/tv/#{show}"`.split("\n")
      
      seasons.each do |season|
        episodes = `ls "public/tv/#{show}/#{season}"`.split("\n")
        
        episodes.each do |ep|
          info = Mediainfo.new "public/tv/#{show}/#{season}/#{ep}"
          if (info.audio[0].format_info != 'Advanced Audio Codec') || (info.video[0].codec_id != 'avc1')
            ep = Episode.new(show,
                        season,
                        ep,
                        (info.audio[0].format_info != 'Advanced Audio Codec'),
                        (info.video[0].codec_id != 'avc1')
              )
            eps_needing_conv << ep
          end
        end
      end
    end

    puts "Found #{eps_needing_conv.count} episodes that need conversion..."

  end
end
