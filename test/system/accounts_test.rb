require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = FactoryBot.create(:account)
    sign_in @account.user
  end

  test 'account has a page with its details' do
    visit account_url(@account)
    assert_text @account.balance
  end

  test 'account can be visited only by the owner' do
    new_account = FactoryBot.create(:account)
    visit account_url(new_account)

    assert page.has_content?(I18n.t('errors.unauthorized'))
    assert_current_path authenticated_root_path
  end
end
