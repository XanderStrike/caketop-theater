# frozen_string_literal: true
FactoryGirl.define do
  factory :comment do
    body 'I love this movie!'
    sequence(:name) { |n| "Anonymous #{n}" }
    movie
  end
end
