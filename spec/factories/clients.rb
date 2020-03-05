FactoryBot.define do
  factory :client do
    title { "MyString" }
    email { Faker::Internet.unique.email }
    phone { "MyString" }
    url   { Faker::Internet.unique.url }
    site  { Faker::Internet.url }
  end
end
