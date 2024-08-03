require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = FactoryBot.create(:account)
    sign_in @account.user
  end

  test 'show page with accounts sumary' do
    other_account = FactoryBot.create(:account, user: @account.user)

    visit accounts_url
    assert_text @account.balance
    assert_text other_account.balance
  end

  test 'show page with account details' do
    visit account_url(@account)
    assert_text @account.balance
  end

  test 'account can be visited only by the owner' do
    new_account = FactoryBot.create(:account)
    visit account_url(new_account)

    assert page.has_content?(I18n.t('errors.general'))
    assert_current_path authenticated_root_path
  end

  test 'show page with accounts transactions' do
    FactoryBot.create(:transaction, sender: @account)
    visit account_url(@account)

    assert_text @account.transactions.first.recipient
  end
end
