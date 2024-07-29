FactoryBot.define do
  factory :transaction do
    recipient { Faker::Commerce.vendor }
    amount_cents { Faker::Number.number(digits: 5) }
    status { Transaction.statuses.values.sample }

    association :sender, factory: :account

    trait :pending do
      status { Transaction.statuses[:pending] }
    end

    trait :completed do
      status { Transaction.statuses[:completed] }
    end

    trait :cancelled do
      statuses { Transaction.statuses[:cancelled] }
    end

    trait :failed do
      status { Transaction.statuses[:failed] }
    end
  end
end
