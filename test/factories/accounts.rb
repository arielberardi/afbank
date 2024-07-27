FactoryBot.define do
  factory :account do
    account_type { Account.account_types.keys.sample }
    balance_cents { Faker::Number.number(digits: 5) }
    currency { Account.currencies.keys.sample }
    user

    trait :checking do
      account_type { Account.account_types['checking'] }
    end

    trait :saving do
      account_type { Account.account_types['savings'] }
    end
  end
end
