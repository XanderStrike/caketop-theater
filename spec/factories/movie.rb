FactoryGirl.define do
  factory :movie do
    added Time.now
    backdrop_path "/edAzJro2SmIVrudHdc0rgrvqVFN.jpg"
    sequence(:budget) {|n| n * 10000}
    sequence(:id) {|n| n + 1000}
    sequence(:imdb_id) {|n| n * 1234}
    sequence(:original_title) {|n| "Movie #{n}"} # pretty sure this is how they picked the title for Movie 43
    sequence(:title) {|n| "Movie #{n}"} # pretty sure this is how they picked the title for Movie 43
    sequence(:overview) {|n| "You'll have to see Movie #{n} to believe it!"}
    sequence(:tagline) {|n| "You'll have to see Movie #{n} to believe it!"}
    sequence(:popularity) {|n| n/1.0 }
    poster_path "/edAzJro2SmIVrudHdc0rgrvqVFN.jpg"
    sequence(:release_date) {|n| Time.now - n.years}
    sequence(:revenue) {|n| n * 1000000}
    sequence(:runtime) {|n| n + 60}
    status "Released"
    sequence(:vote_average) {|n| n/10.0}
    sequence(:vote_count) {|n| n*10}

    after(:create) do |movie|
      3.times do
        create(:genre, movie: movie)
      end
    end
  end
end
