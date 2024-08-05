require 'test_helper'

class TransferServiceTest < ActiveSupport::TestCase
  setup do
    @transfer_amount = 100_000
    @sender = FactoryBot.create(:account, balance_cents: @transfer_amount + 1, currency: 'gbp')
    @recipient = FactoryBot.create(:account, currency: 'gbp')
    @transfer_service = TransferService.new
  end

  test 'create a transfer with status pending and enqueues job to make finalize the transfer async' do
    transfer = @transfer_service.create(@sender, @recipient, @transfer_amount)

    assert transfer.pending?
    assert_equal Transfer.last, transfer
    assert_enqueued_jobs 1, only: TransferExecutionJob
  end

  test 'cancel the operation if account does not have funds' do
    transfer_count = Transfer.count

    assert_raises { @transfer_service.create(@sender, @recipient, @sender.balance_cents + 1) }
    assert_equal transfer_count, Transfer.count
    assert_enqueued_jobs 0
  end

  test 'raise error if either sender or recipient does not exists' do
    assert_raises { @transfer_service.create(nil, @recipient, @transfer_amount_000) }
    assert_raises { @transfer_service.create(@sender, nil, @transfer_amount) }
  end

  test 'raise error if amount to transfer is 0 or below' do
    assert_raises { @transfer_service.create(@sender, @recipient, 0) }
    assert_raises { @transfer_service.create(@sender, @recipient, -1) }
  end

  test 'executes the transfer changing balances of both accounts' do
    sender_initial_balance = @sender.balance_cents
    recipient_initial_balance = @recipient.balance_cents

    transfer = FactoryBot.create(:transfer,
                                 sender: @sender,
                                 recipient: @recipient,
                                 amount_cents: @transfer_amount)

    @transfer_service.execute(transfer.id)

    assert Transfer.find(transfer.id).completed?
    assert_equal sender_initial_balance - @transfer_amount, Account.find(@sender.id).balance_cents
    assert_equal recipient_initial_balance + @transfer_amount, Account.find(@recipient.id).balance_cents
  end

  test 'raise error if sender does not have enough funds' do
    transfer = FactoryBot.create(:transfer, sender: @sender, amount_cents: @sender.balance_cents + 1)
    assert_raises { @transfer_service.execute(transfer.id) }
  end
end
