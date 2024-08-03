class Contact < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :account_id, uniqueness: { scope: :user_id }

  after_create_commit -> { broadcast_append_later_to 'contacts' }
  after_update_commit -> { broadcast_replace_later_to 'contacts' }
  after_destroy_commit -> { broadcast_remove_to 'contacts' }
end
