class Account < ApplicationRecord
  enum account_type: { savings: 'savings', checking: 'checking' }
  enum currency: { gbp: 'gbp', usd: 'usd', eur: 'eur' }

  belongs_to :user

  validates :account_type, presence: true
  validates :currency, presence: true

  def balance
    return 0 if balance_cents.zero? || balance_cents.nil?

    balance_cents / 100
  end
end
