FactoryBot.define do
  factory :transaction do
    amount_cents { Faker::Number.number(digits: 5) }
    status { Transaction.statuses.values.sample }
    association :sender, factory: :account
    association :recipient, factory: :account

    trait :pending do
      status { Transaction.statuses[:pending] }
    end

    trait :completed do
      status { Transaction.statuses[:completed] }
    end

    trait :canceled do
      statuses { Transaction.statuses[:canceled] }
    end

    trait :failed do
      status { Transaction.statuses[:failed] }
    end
  end
end
