require 'application_system_test_case'

class ContactsTest < ApplicationSystemTestCase
  setup do
    @contact = FactoryBot.create(:contact)
    sign_in @contact.user
  end

  test 'visiting the index' do
    visit contacts_url
    assert_text @contact.account_id
  end

  test 'should create contact' do
    visit contacts_url
    find('[data-test-id="add-contact"]').click

    account = FactoryBot.create(:account)

    fill_in 'Alias', with: 'TestContact'
    fill_in 'Account', with: account.id
    click_on 'Create Contact'

    assert_text 'Contact was successfully created'
  end

  test 'should update Contact' do
    visit contacts_url
    find('[data-test-id="edit-contact"]', match: :first).click

    fill_in 'Alias', with: 'TestContact'
    fill_in 'Account', with: @contact.account_id
    click_on 'Update Contact'

    assert_text 'Contact was successfully updated'
  end

  test 'should destroy Contact' do
    visit contacts_url
    find('[data-test-id="delete-contact"]', match: :first).click

    assert_text 'Contact was successfully deleted'
  end
end
