require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.create(:user)
  end

  test 'can be created' do
    assert @user.valid?
  end

  test 'all fields must be presence' do
    assert validate_presence_of(:username)
    assert validate_presence_of(:email)
    assert validate_presence_of(:password)
    assert validate_presence_of(:first_name)
    assert validate_presence_of(:second_name)
    assert validate_presence_of(:phone_number)
    assert validate_presence_of(:birth_date)
    assert validate_presence_of(:password_confirmation)
  end

  test 'username and email must unique' do
    assert validate_uniqueness_of(:username)
    assert validate_uniqueness_of(:email)
  end

  test 'email must have a valid format' do
    invalid_emails = [
      'test',
      'test@example',
      'example.com'
    ]

    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?
    end

    valid_emails = [
      'test@test.com',
      'test_test@example.com',
      'test.test@example.com',
      'test@example.com'
    ]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?
    end
  end

  test 'password must have a valid format' do
    invalid_passwords = [
      '',
      'test',
      'testlong',
      'Capital',
      'Capital8Number',
      'Capital@'
    ]

    invalid_passwords.each do |password|
      @user.password = password
      assert_not @user.valid?
    end
  end

  test 'password confirmation must match password' do
    @user.password_confirmation = 'wrong'
    assert_not @user.valid?
  end

  test 'phone number must be from UK' do
    invalid_phone_numbers = [
      '',
      '123456789',
      '123456789012',
      '12345678901'
    ]

    invalid_phone_numbers.each do |phone_number|
      @user.phone_number = phone_number
      assert_not @user.valid?
    end
  end

  test 'must be over 18 years' do
    @user.birth_date = 17.years.ago
    assert_not @user.valid?
  end

  test 'age under 18 raises a DB constraint' do
    error = assert_raises(ActiveRecord::StatementInvalid) do
      # update_column skips validation, usefull for testing DB constraints
      # rubocop:disable Rails/SkipsModelValidations
      @user.update_column(:birth_date, 17.years.ago)
      # rubocop:enable Rails/SkipsModelValidations
    end

    assert_match(/birth_date_age_check/, error.message)
  end

  test 'method fullname returns the first and last name separated by a space' do
    fullname = "#{@user.first_name} #{@user.last_name}"
    assert_equal @user.fullname, fullname
  end
end
