FactoryGirl.define do
  factory :artist do
    sequence(:name) {|n| "Artist #{n}"}
    sequence(:url) {|n| "http://artist#{n}.com"}
    sequence(:bio) {|n| "This is a little about artist #{n}"}
    sequence(:year) {|n| n + 2000}
    sequence(:home) {|n| "#{n} County, California"}
    image "music/artist/image.jpg"



    factory :artist_with_albums do
      after(:create) do |artist|
        create_list(:album, 5, artist: artist)
      end
    end

    factory :artist_with_albums_and_songs do
      after(:create) do |artist|
        create_list(:album_with_songs, 5, artist: artist)
      end
    end
  end
end
