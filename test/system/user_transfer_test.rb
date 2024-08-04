require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @sender = FactoryBot.create(:account, balance_cents: 100_00)
    @recipient = FactoryBot.create(:account, currency: @sender.currency)

    @contact = FactoryBot.create(:contact, account: @recipient, user: @sender.user)

    sign_in @sender.user
  end

  test 'creates an async transaction between accounts' do
    transfer_count = Transfer.count

    visit new_transfer_path

    select @contact.name, from: 'transfer[contact_id]'
    select @sender.id, from: 'transfer[sender_account_id]'
    fill_in 'Amount', with: 1
    click_on 'Create Transfer'

    assert_equal Transfer.count, transfer_count + 1
    assert Transfer.last.pending?
  end
end
