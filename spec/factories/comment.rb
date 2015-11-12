FactoryGirl.define do
  factory :comment do
    body '# I love this movie!'
    sequence(:name) { |n| "Anonymous #{n}" }
    movie
  end
end
