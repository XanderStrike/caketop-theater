# frozen_string_literal: true
FactoryGirl.define do
  factory :show do
    backdrop_path '/fadsfasdfadsfasdfhfsadfds.jpg'
    sequence(:first_air_date) { |n| Time.now - n.years }
    sequence(:id) { |n| n + 1000 }
    sequence(:name) { |n| "Show #{n}" }
    sequence(:folder) { |n| "Show #{n}" }
    sequence(:original_name) { |n| "Original Show #{n}" }
    sequence(:overview) { |n| "This is some information about Show #{n}" }
    sequence(:popularity) { |n| n * 455 }
    poster_path '/fasfhkasdfeoiurqewnbflads.jpg'
    sequence(:vote_average) { |n| n / 10.0 }
    sequence(:vote_count) { |n| n * 10 }
  end
end
