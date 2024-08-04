class TransfersController < ApplicationController
  def index
    @transfers = Transfer.where(recipient_id: current_user.account_ids)
                         .or(Transfer.where(sender_id: current_user.account_ids))
                         .includes(sender: :user)
                         .includes(recipient: :user)
  end

  def show
    @transfer = Transfer.find(params[:id])
  end

  def new
    @transfer = Transfer.new
  end

  def create
    transfer_params = params.require(:transfer)
                            .permit(:contact_id, :amount_cents, :sender_account_id)

    sender_account = current_user.accounts.find(transfer_params[:sender_account_id])
    recipient_account = Contact.find(transfer_params[:contact_id]).account
    amount_cents = transfer_params[:amount_cents].to_f * 100

    @transfer = TransferService.new.create(sender_account, recipient_account, amount_cents)

    if @transfer.persisted?
      respond_to do |format|
        format.html { redirect_to transfers_url, notice: I18n.t('controller.contacts.created') }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
end
