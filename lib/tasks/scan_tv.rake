# frozen_string_literal: true
namespace :scan do
  desc 'Scans for changes in the TV library folder.'
  task tv: :environment do
    puts 'Scanning for new tv shows:'

    # create tv symlink
    setting = Setting.get(:tv_dir)
    if !File.exist?('public/tv') || setting.boolean
      puts 'Creating symlink for new tv directory.'
      begin
        File.unlink('public/tv')
      rescue
        nil
      end
      File.symlink(Setting.get(:tv_dir).content, 'public/tv')
      setting.update_attributes(boolean: false)
    end

    files = `ls public/tv `.split("\n").map { |f| f.gsub('public/tv/', '') }

    files.each do |file|
      puts file
      show = TmdbService.search_tv_title(file).first

      if show.nil?
        puts "Error: Title for '#{file}' not found, skipping."
        next
      end

      next if Show.where(id: show.id).count > 0

      # insert into db
      puts "Adding #{file}\n    as #{show.name}"
      info = TmdbService.get_tv_info(show.id)
      show_id = info['id']
      Show.create(backdrop_path: info['backdrop_path'],
                  id: show_id,
                  original_name:  info['original_name'],
                  first_air_date:  info['first_air_date'],
                  poster_path:  info['poster_path'],
                  popularity:  info['popularity'],
                  name:  info['name'],
                  vote_average:  info['vote_average'],
                  vote_count:  info['vote_count'],
                  overview:  info['overview'],
                  folder:  file)

      # populate genres table
      info['genres'].each do |g|
        begin
          Genre.create(genre_id: g['id'], name: g['name'], movie_id: show.id)
        rescue
          nil
        end
      end

      # download images
      `wget http://image.tmdb.org/t/p/w500/#{ info['poster_path'] } -O ./public/posters/tv_#{show_id}.jpg -b -q`
      `wget http://image.tmdb.org/t/p/w1000/#{ info['backdrop_path'] } -O ./public/backdrops/tv_#{show_id}.jpg -b -q`
    end

    puts 'TV scan complete.'
  end
end
