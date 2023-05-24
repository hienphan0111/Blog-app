FactoryBot.define do
  factory :user do
    # add attributes and their values here
    name { "John Doe" }
    bio { "john@example.com" }
    photo { "http" }
    posts_counter { 0 }
  end
end
