class Transaction < ApplicationRecord
  enum status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled', failed: 'failed' }

  belongs_to :sender, class_name: 'Account'
  belongs_to :recipient, class_name: 'Account'

  validates :amount_cents, presence: true
  validates :amount_cents, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def amount
    return 0 if amount_cents.zero?

    amount_cents / 100.0
  end
end
