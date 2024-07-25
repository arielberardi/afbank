FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 'Password@123' }
    password_confirmation { 'Password@123' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth_date { Faker::Date.birthday(min_age: 18) }
    phone_number { '+447909555555' }
    confirmed_at { 1.day.ago }
  end
end
