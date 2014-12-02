FactoryGirl.define do
  factory :album do
    sequence(:name) {|n| "Album #{n}"}
    sequence(:year) {|n| n + 2000}
    art "music/artist/album/cover.jpg"
    genre "Rock"

    artist

    factory :album_with_songs do
      after(:create) do |album|
        create_list(:song, 10, album: album)
      end
    end
  end
end
