FactoryBot.define do
  factory :post do
    # add attributes and their values here
    title { "post" }
    text { "Content" }
    author { association :user }
    comments_counter { 0 }
    likes_counter { 0 }
  end
end