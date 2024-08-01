class Contact < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :account_id, uniqueness: { scope: :user_id }
end
