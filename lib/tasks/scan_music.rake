class SongInfo
  attr_accessor :format, :file_size, :duration, :bitrate, :bitrate_mode, :artist, :album, :title, :track, :composer, :genre, :record_date

  def initialize(filepath)
    m = Mediainfo.new("public/#{filepath}")

    @format = m.streams.first.parsed_response[:general]["format"]
    @file_size = m.streams.first.parsed_response[:general]["file_size"]
    @duration = m.streams.first.parsed_response[:general]["duration"]
    @bitrate = m.streams.first.parsed_response[:general]["overall_bit_rate"]
    @bitrate_mode = m.streams.first.parsed_response[:general]["overall_bit_rate_mode"]
    @artist = m.streams.first.parsed_response[:general]["performer"]
    @album = m.streams.first.parsed_response[:general]["album"]
    @title = m.streams.first.parsed_response[:general]["track_name"]
    @track = m.streams.first.parsed_response[:general]["track_name_position"]
    @composer = m.streams.first.parsed_response[:general]["composer"]
    @genre = m.streams.first.parsed_response[:general]["genre"]
    @record_date = m.streams.first.parsed_response[:general]["recorded_date"]
  end
end

namespace :scan do
  desc "Scan for new music in library folder."
  task :music => :environment do
    puts "Scanning for new music:"

    files = `find public/music/ -type f | grep \.mp3$`.split("\n").map {|f| f.gsub('public/', '')}
    db_files = Song.select(:filename).map(&:filename)
    new_files = files - db_files

    new_files.each do |f|
      s = SongInfo.new(f)
      puts "Adding #{s.title} by #{s.artist} from #{s.album}"

      artist = Artist.where(name: s.artist).first || Artist.create(name: s.artist)
      artist.save!

      # i don't think this works right
      filepath = f.split('/')[0...f.split('/').size-1].join('/')
      album_art = `ls #{"public/#{filepath}".shellescape} | grep #{'\.jpg$\|\.png$\|\.jpeg$'.shellescape}`.split("\n").first
      puts "#{filepath}/#{album_art}"

      album = artist.albums.where(name: s.album).first || artist.albums.create(
        name: s.album,
        year: s.record_date,
        genre: s.genre,
        art: (album_art.nil? ? nil : "#{filepath}/#{album_art}")
        )
      album.save!

      song = album.songs.where(filename: f).first || album.songs.create(
        title: s.title,
        track: s.track,
        filename: f)
      song.save!
    end
  end
end
