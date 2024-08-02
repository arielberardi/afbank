class AccountsController < ApplicationController
  # Getting accounts from current_user avoid not owners getting access to it

  def index
    @accounts = current_user.accounts
  end

  def show
    respond_to do |format|
      format.html do
        @account = current_user.accounts.find(params[:id])
      end
      format.json do
        account = Account.find(params[:id])
        render json: { full_name: account.user.fullname }
      end
    end
  end
end
