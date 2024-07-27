class AccountsController < ApplicationController
  def show
    @account = Account.find(params[:id])

    return unless @account.user != current_user

    @account = nil
    redirect_to authenticated_root_path, alert: I18n.t('errors.unauthorized')
  end
end
