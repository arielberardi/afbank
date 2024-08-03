require 'application_system_test_case'

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = FactoryBot.create(:transaction)
    sign_in @transaction.sender.user
  end

  test 'show page with transactions details' do
    visit transaction_url(@transaction)

    assert_text @transaction.id
    assert_text @transaction.recipient
    assert_text @transaction.amount
    assert_text @transaction.sender.id
  end
end
