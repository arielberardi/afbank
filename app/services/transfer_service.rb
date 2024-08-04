class TransferService
  def create(sender, recipient, amount_cents)
    raise 'Sender and recipient are not in same currency' if sender.currency != recipient.currency
    raise 'Sender has not enough funds' if amount_cents > sender.balance_cents

    transfer = Transfer.create(sender:, recipient:, amount_cents:,
                               currency: sender.currency)
    transfer.save!

    TransferExecutionJob.perform_later(transfer.id)

    transfer
  end

  def execute(transfer_id)
    transfer = Transfer.find(transfer_id)

    raise 'Transfer is not in pending state' unless transfer.pending?

    sender = transfer.sender
    recipient = transfer.recipient

    raise 'Sender has not enough funds' if sender.balance_cents < transfer.amount_cents

    ActiveRecord::Base.transaction do
      sender.update!(balance_cents: sender.balance_cents -= transfer.amount_cents)
      recipient.update!(balance_cents: recipient.balance_cents += transfer.amount_cents)
      transfer.completed!
    end

    transfer
  rescue StandardError => e
    transfer&.failed!
    raise e
  end
end
