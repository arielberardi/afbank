class AccountsController < ApplicationController
  # Getting accounts from current_user avoid other getting access to
  # other users' accounts

  def index
    @accounts = current_user.accounts
  end

  def show
    @account = current_user.accounts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to authenticated_root_path, alert: I18n.t('errors.general')
  end
end
