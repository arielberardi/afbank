class TransferExecutionJob < ApplicationJob
  def perform(transfer_id)
    TransferService.new.execute(transfer_id)
  end
end
