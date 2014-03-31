require 'taglib'
require 'shellwords'

music_directory = "public/music"

def get_music_info(fp)
  unless fp.include?("iTunes")
    songs = []
    songpaths = `ls #{Shellwords.escape(fp)}`.split("\n").map {|f| f.insert(0, "#{fp}/")}
    songpaths.each do |path|
      if File.directory?(path)
        songs.concat(get_music_info(path))
        next
      end
      TagLib::FileRef.open(path) do |fileref|
        unless fileref.null?
          song = fileref.tag
          songs << { :filepath => URI.encode(path),
            :filename => URI.encode(path.split('/')[-1]),
            :title => song.title,
            :artist => song.artist,
            :album => song.album,
            :track => song.track,
            :album_art_path => get_album_art(fp),
            :year => song.year,
            :genre => song.genre}
        end
      end
    end
    return songs
  end
  return []
end

def get_album_art(fp)
  paths = `ls #{Shellwords.escape(fp)}`.split("\n").map {|f| f.insert(0, "#{fp}/")}
  paths.each do |p|
    if p.end_with?(".jpg", ".png")
      return (p.split('/public/music/').last) # iTunes can mess this up.
    end
  end
end


def populate(root)
  puts "Scanning for new music:"
  root.each do |dir|
    infos = get_music_info(dir)
    infos.each do |info|
      artist = Artist.where(name: info[:artist]).first || Artist.create(name: info[:artist])
      artist.save!
      album = artist.albums.where(name: info[:album]).first || artist.albums.create(name: info[:album],
                                                                      art: info[:album_art_path],
                                                                      year: info[:year],
                                                                                    genre: info[:genre])
      album.save
      song = album.songs.where(filepath: info[:filepath]).first || album.songs.create(title: info[:title],
                                                                         track: info[:track],
                                                                         filename: info[:filename],
                                                                               filepath: info[:filepath])
      song.save!
      artist.save!
    end
  end
  puts "Done."
end

namespace :scan do
  desc "Scan for new music in library folder."
  task :music => :environment do
    puts "Scanning for new music:"
    puts "music direcory: #{music_directory}"
    filepaths = `ls #{music_directory}`.split("\n").map {|f| f.insert(0, "#{music_directory}/")}
    puts "found: #{filepaths.length} first: #{filepaths.first}"
    populate(filepaths)
  end
end
