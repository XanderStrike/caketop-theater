# frozen_string_literal: true
FactoryGirl.define do
  factory :movie do
    added Time.now
    backdrop_path '/edAzJro2SmIVrudHdc0rgrvqVFN.jpg'
    sequence(:budget) { |n| n * 10_000 }
    sequence(:id) { |n| n + 1000 }
    sequence(:imdb_id) { |n| n * 1234 }
    sequence(:original_title) { |n| "Movie #{n}" }
    sequence(:title) { |n| "Movie #{n}" } # pretty sure this is how they picked the title for Movie 43
    sequence(:overview) { |n| "You'll have to see Movie #{n} to believe it!" }
    sequence(:tagline) { |n| "You'll have to see Movie #{n} to believe it!" }
    sequence(:popularity) { |n| n / 1.0 }
    poster_path '/edAzJro2SmIVrudHdc0rgrvqVFN.jpg'
    sequence(:release_date) { |n| Time.now - n.years }
    sequence(:revenue) { |n| n * 1_000_000 }
    sequence(:runtime) { |n| n + 60 }
    status 'Released'
    sequence(:vote_average) { |n| n / 10.0 }
    sequence(:vote_count) { |n| n * 10 }

    after(:create) do |movie|
      create_list(:genre, 3, movie: movie)
      create_list(:encode, 2, movie: movie)
    end

    factory :movie_with_comments do
      after(:create) do |movie|
        create_list(:comment, 50, movie: movie)
      end
    end

    factory :movie_with_views do
      after(:create) do |movie|
        create_list(:view, rand(100), movie: movie)
      end
    end
  end
end
