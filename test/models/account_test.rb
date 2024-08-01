require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = FactoryBot.create(:account)
  end

  test 'can create a new account' do
    assert @account.valid?
  end

  test 'type and currency must be present' do
    assert validate_presence_of(:account_type)
    assert validate_presence_of(:currency)
  end

  test 'must belong to a user' do
    assert belong_to(:user)
  end

  test 'have many transations' do
    assert have_many(:transactions)
  end

  test 'have many contacts' do
    assert have_many(:contacts)
  end

  test '#balance returns balance with cents' do
    balance = @account.balance_cents / 100
    assert_equal @account.balance, balance.round
  end
end
