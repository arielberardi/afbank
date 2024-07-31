class Transaction < ApplicationRecord
  enum status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled', failed: 'failed' },
       default: 'pending'

  belongs_to :sender, class_name: 'Account'

  validates :recipient, presence: true
  validates :amount_cents, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def amount
    return 0 if amount_cents.zero?

    amount_cents / 100.0
  end
end
