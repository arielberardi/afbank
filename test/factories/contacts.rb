FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    user
    account
  end
end
