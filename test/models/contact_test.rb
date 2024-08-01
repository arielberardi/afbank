require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @contact = FactoryBot.create(:contact)
  end

  test 'can create a new contact' do
    assert @contact.valid?
  end

  test 'user can not repeate same contact' do
    repeated_contact = FactoryBot.build(:contact, user: @contact.user, account: @contact.account)
    assert repeated_contact.invalid?
  end

  test 'contact must have a name' do
    @contact.name = nil
    assert @contact.invalid?
  end

  test 'contact name must be unique for same user' do
    repeated_contact = FactoryBot.build(:contact, user: @contact.user, name: @contact.name)
    assert repeated_contact.invalid?
  end

  test 'belongs to user and account' do
    assert belong_to(:user)
    assert belong_to(:account)
  end
end
