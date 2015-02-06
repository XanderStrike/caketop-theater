FactoryGirl.define do
  factory :genre do
  	sequence(:id) {|n| n}
    sequence(:name) {|n| "Genre #{n}"}
    movie
  end
end
