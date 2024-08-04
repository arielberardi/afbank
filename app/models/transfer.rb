class Transfer < ApplicationRecord
  attr_accessor :contact_id, :sender_account_id

  enum status: { pending: 'pending', completed: 'completed', failed: 'failed' }

  belongs_to :sender, class_name: 'Account'
  belongs_to :recipient, class_name: 'Account'

  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validate :sender_and_recipient_are_different

  after_create_commit -> { broadcast_append_later_to 'transfers' }
  after_update_commit -> { broadcast_replace_later_to 'transfers' }

  def amount
    return 0 if amount_cents.zero?

    amount_cents / 100.0
  end

  private

  def sender_and_recipient_are_different
    errors.add(:recipient, I18n.t('activerecord.attributes.transfer.error.same_recipient')) if sender == recipient
  end
end
