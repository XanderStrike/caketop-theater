# frozen_string_literal: true
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
    if @audio && @video
      `avconv -i "public/tv/#{@show}/#{@season}/#{@filename}" -strict experimental "public/tv/#{@show}/#{@season}/#{@filename}.mp4"`
      `rm "public/tv/#{@show}/#{@season}/#{@filename}"`
    elsif @audio
      `avconv -i "public/tv/#{@show}/#{@season}/#{@filename}" -c:v copy -strict experimental "public/tv/#{@show}/#{@season}/#{@filename}.mp4"`
      `rm "public/tv/#{@show}/#{@season}/#{@filename}"`
    elsif @video
      `avconv -i "public/tv/#{@show}/#{@season}/#{@filename}" -c:a copy -strict experimental "public/tv/#{@show}/#{@season}/#{@filename}.mp4"`
      `rm "public/tv/#{@show}/#{@season}/#{@filename}"`
    end
  end
end

namespace :convert do
  desc 'Converts TV shows that are not in good HTML5 formats'
  task tv: :environment do
    # How many episodes to do per
    limit = 50

    # Gotta do it folder by folder because we don't keep episode information.
    # Probably a problem.

    puts 'Finding episodes that need conversion...'

    shows = `ls public/tv`.split("\n")

    eps_needing_conv = []
    shows.each do |show|
      seasons = `ls "public/tv/#{show}"`.split("\n")

      seasons.each do |season|
        episodes = `ls "public/tv/#{show}/#{season}"`.split("\n")

        episodes.each do |ep|
          break if eps_needing_conv.count > limit
          begin
            info = Mediainfo.new "public/tv/#{show}/#{season}/#{ep}"
            if (info.audio[0].format_info != 'Advanced Audio Codec') || (info.video[0].format_info != 'Advanced Video Codec')
              ep = Episode.new(show,
                               season,
                               ep,
                               (info.audio[0].format_info != 'Advanced Audio Codec'),
                               (info.video[0].format_info != 'Advanced Video Codec')
                              )
              eps_needing_conv << ep
              puts "- #{ep}"
            end
          rescue
          end
        end
      end
    end

    puts "Found #{eps_needing_conv.count} episodes that need conversion..."

    puts 'Starting conversion...'
    eps_needing_conv.first(25).map(&:convert)
    puts 'Done.'
  end
end
