class ContactsController < ApplicationController
  before_action :set_contact, only: %i[edit update destroy]
  before_action :set_account, only: %i[create update]

  def index
    @contacts = current_user.contacts.includes(account: :user)
  end

  def new
    @contact = current_user.contacts.new
  end

  def edit; end

  def create
    @contact = current_user.contacts.new(name: contact_params[:name], account: @account)

    if @contact.save
      respond_to do |format|
        format.html { redirect_to contacts_url, notice: I18n.t('controller.contacts.created') }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(name: contact_params[:name], account: @account)
      respond_to do |format|
        format.html { redirect_to contacts_url, notice: I18n.t('controller.contacts.updated') }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy!

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: I18n.t('controller.contacts.deleted') }
      format.turbo_stream
    end
  end

  private

  def set_contact
    @contact = current_user.contacts.find(params[:id])
  end

  def set_account
    # Find account from account_id to avoid mass assignment risks (Brakeman)
    @account = Account.find(contact_params[:account_id])
  end

  def contact_params
    params.require(:contact).permit(:name, :account_id)
  end
end
