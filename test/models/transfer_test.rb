require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  setup do
    @transfer = FactoryBot.create(:transfer)
  end

  test 'valid transfer' do
    assert @transfer.valid?
  end

  test 'belong to a sender and a recipient' do
    assert belong_to(:sender)
    assert belong_to(:recipient)
  end

  test 'invalid transfer without amount' do
    @transfer.amount_cents = nil
    assert @transfer.invalid?
  end

  test 'invalid transfer when amount is 0 or below' do
    @transfer.amount_cents = 0
    assert @transfer.invalid?

    @transfer.amount_cents = -1
    assert @transfer.invalid?
  end

  test 'raise exception in DB if amount is 0 or lower' do
    assert_raises ActiveRecord::RecordInvalid do
      ActiveRecord::Base.transaction do
        Transfer.create!(sender: @sender, recipient: @recipient, amount_cents: 0)
      end
    end

    assert_raises ActiveRecord::RecordInvalid do
      ActiveRecord::Base.transaction do
        Transfer.create!(sender: @sender, recipient: @recipient, amount_cents: -1)
      end
    end
  end

  test 'amount returns a decimal of amount_cents' do
    assert_equal @transfer.amount, @transfer.amount_cents / 100.0
  end

  test 'sender and recipient must not be the same account' do
    @transfer.recipient = @transfer.sender
    assert @transfer.invalid?
  end
end
