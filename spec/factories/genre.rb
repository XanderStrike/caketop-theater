FactoryGirl.define do
  factory :genre do
  	sequence(:genre_id) {|n| n}
    sequence(:name) {|n| "Genre #{n}"}
    movie
  end
end
