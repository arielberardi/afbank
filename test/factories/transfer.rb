FactoryBot.define do
  factory :transfer do
    amount_cents { Faker::Number.between(from: 1, to: 100_000) }
    status { Transfer.statuses[:pending] }
    currency { 'gbp' }

    association :sender, factory: :account
    association :recipient, factory: :account
  end
end
