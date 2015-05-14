namespace :convert do
  desc "Converts movies that are not in good HTML5 formats"
  task :movies => :environment do

    puts "Scanning movie library..."
    Rake::Task["scan:movies"].invoke

    puts "Looking for movies needing audio conversion..."
    enc = Encode.where('a_format != ?', 'Advanced Audio Codec').map(&:filename)

    puts "Found #{enc.count} movies that need conversion."

    enc.each do |filename|
      puts "Converting audo for: #{filename}"
      `avconv -i "public/movies/#{filename}" -c:v copy -strict experimental "/tmp/#{filename}.mp4"`
      `rm "public/movies/#{filename}"`
    end

    puts "Copying transcoded movies..."
    `mv "/tmp/"*".mp4" public/movies/`

    puts "Rescanning..."
    Rake::Task["scan:movies"].reenable
    Rake::Task["scan:movies"].invoke

    puts "Looking for movies needing video conversion..."
    enc = Encode.where('v_codec != ?', 'avc1').map(&:filename)

    puts "Found #{enc.count} movies that need conversion."
    enc.each do |filename|
      puts "Converting video for: #{filename}"
      `avconv -i "public/movies/#{filename}" -c:a copy "/tmp/#{filename}.mp4"`
      `rm "public/movies/#{filename}"`
    end

    puts "Copying transcoded movies..."
    `mv "/tmp/"*".mp4" public/movies/`

    puts "Rescanning..."
    Rake::Task["scan:movies"].reenable
    Rake::Task["scan:movies"].invoke

    puts "Done."
  end
end
