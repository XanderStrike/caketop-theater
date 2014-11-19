FactoryGirl.define do
  factory :genre do
    sequence(:name) {|n| "Genre #{n}"}
    movie
  end
end
