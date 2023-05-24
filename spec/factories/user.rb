FactoryBot.define do
  factory :user do
    # add attributes and their values here
    name { "John Doe" }
    bio { "john@example.com" }
    photo { "http" }
    after(:create) do |user|
      create_list(:post, 0, user: user)
    end
  end
end
