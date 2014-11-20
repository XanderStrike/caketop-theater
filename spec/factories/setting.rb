FactoryGirl.define do
  factory :setting do
    sequence(:name) {|n| "Setting #{n}"}
    sequence(:content) {|n| "This is the contents of the setting!"}
    sequence(:number) {|n| n}
    boolean true
  end
end
