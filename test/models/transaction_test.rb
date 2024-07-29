require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = FactoryBot.create(:transaction)
  end

  test 'valid transaction' do
    assert @transaction.valid?
  end

  test 'belong to a sender and a recipient' do
    assert belong_to(:sender)
    assert belong_to(:recipient)
  end

  test 'invalid transaction without amount' do
    @transaction.amount_cents = nil
    assert_not @transaction.valid?
  end

  test 'amount returns a decimal of amount_cents' do
    assert_equal @transaction.amount, @transaction.amount_cents / 100.0
  end
end
