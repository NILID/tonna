FactoryBot.define do
  factory :container do
    content { "MyText" }
    types_mask { 'text' }
    association :project, :with_preview
  end
end
