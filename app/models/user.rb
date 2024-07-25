class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, presence: true, format: { with: /(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{7,}/ }
  validates :first_name, :last_name, presence: true
  validates :birth_date, presence: true
  validates :password_confirmation, presence: true
  validate :user_is_an_adult
  validates :phone_number, presence: true, format: {
    with: /(?:\+44|0)7\d{9}|(?:\+44|0)2\d{9}|(?:\+44|0)3\d{9}|(?:\+44|0)8\d{9}|(?:\+44|0)1\d{9}/
  }

  private

  def user_is_an_adult
    return if birth_date.blank?
    return if birth_date < 18.years.ago.to_date

    errors.add(:birth_date, I18n.t('activerecord.errors.models.user.attributes.birth_date.invalid'))
  end
end
