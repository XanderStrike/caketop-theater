FactoryGirl.define do
  factory :page do
    sequence(:text) {|n| "# Page #{n} \n\n This is a test page!" }
    sequence(:name) {|n| "Page #{n}"}
    navbar true
    footer true
  end
end
