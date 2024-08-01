class ContactsController < ApplicationController
  before_action :set_contact, only: %i[edit update destroy]

  # GET /contacts or /contacts.json
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/new
  def new
    @contact = current_user.contacts.new
  end

  # GET /contacts/1/edit
  def edit; end

  # POST /contacts
  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      redirect_to contact_url(@contact), notice: I18n.t('controller.contacts.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      redirect_to contact_url(@contact), notice: I18n.t('controller.contacts.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy!

    redirect_to contacts_url, notice: I18n.t('controller.contacts.deleted')
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:alias, :account_id)
  end
end
