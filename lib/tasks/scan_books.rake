require 'epub/parser'

namespace :scan do
  task books: :environment do
    puts "Scanning for books:"

    files = `find public/books/ -type f | grep \.epub$`.split("\n").map { |f| f.gsub("//", "/") }
    db_files = Book.select(:filename).map(&:filename)
    new_files = files - db_files
    new_files.each do |f|
      book = EPUB::Parser.parse("#{f}")
      puts "adding #{book.metadata.title}"
      Book.create(title: book.metadata.title, filename: f)
    end
  end
end
