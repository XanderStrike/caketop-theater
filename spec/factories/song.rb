FactoryGirl.define do
  factory :song do
    sequence(:filename) { |n| "Track #{n}.mp3" }
    sequence(:title) { |n| "Track #{n}" }
    sequence(:track) { |n| n }

    album
  end
end
