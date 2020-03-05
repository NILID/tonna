FactoryBot.define do
  factory :project do
    title { "MyString" }
    desc { "MyText" }
    hide { true }

    trait(:with_preview) { preview { Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/ru.png'), 'image/png') } }
  end
end
