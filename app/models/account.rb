class Account < ApplicationRecord
  enum account_type: { savings: 'savings', checking: 'checking' }
  enum currency: { gbp: 'gbp', usd: 'usd', eur: 'eur' }

  belongs_to :user
  has_many :transactions, class_name: 'Transaction', foreign_key: 'sender_id', inverse_of: :sender, dependent: :destroy

  validates :account_type, presence: true, inclusion: { in: account_types.keys }
  validates :currency, presence: true, inclusion: { in: currencies.keys }

  def balance
    return 0 if balance_cents.zero? || balance_cents.nil?

    balance_cents / 100
  end
end
