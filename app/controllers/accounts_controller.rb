class AccountsController < ApplicationController
  # Getting accounts from current_user avoid not owners getting access to it

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
  end
end
