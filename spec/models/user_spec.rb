require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = build(:user)
  end

  it 'is valid name with a name' do
    @user.name = 'Kaemon'
    expect(@user).to be_valid
  end

  it 'name cannot be over fo characters' do
    @user.name = 'a' * 51
    expect(@user).to_not be_valid
  end

  it 'is invalid with an empty name' do
    @user.name = ''
    expect(@user).to_not be_valid
  end

  it 'is invalid with an empty email' do
    @user.email = ''
    expect(@user).to_not be_valid
  end

  it 'should reject invalid email addressees' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid, "#{invalid_address} should be invalid"
    end
  end

  it 'should except valid email addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid."
    end
  end

  it 'should save the user email as lower-case' do
    @user.email = 'ThIsIsAfAkE@EmAiL.com'
    @user.save
    expect(@user.email).to eq('thisisafake@email.com')
  end

  it 'is invalid with an email length over 255' do
    @user.email = 'a' * 244 + "@example.com"
    expect(@user).to_not be_valid
  end

  it 'is valid with a unique email' do
    @user.email = 'test@example.com'
    expect(@user).to be_valid
  end

  it 'is invalid with an identical email' do
    @user.save
    @dup_user = build(:user, email: @user.email)
    expect(@dup_user).to_not be_valid
  end

  it 'must have a minimum password length of 6' do
    @user.password = '12345'
    expect(@user).to_not be_valid
  end
end
