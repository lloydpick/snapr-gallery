require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new
    @user.username = "Username"
    @user.emailaddress = "username@somewhere.com"
    @user.password = "5f4dcc3b5aa765d61d8327deb882cf99"
  end

  def test_user_should_always_have_a_username
    @user.username = nil
    assert !@user.save, "Saved user without a username"
  end

  def test_user_should_always_have_an_emailaddress
    @user.emailaddress = nil
    assert !@user.save, "Saved user without an email address"
  end

  def test_user_should_always_have_a_password
    @user.password = nil
    assert !@user.save, "Saved user without a password"
  end

  def test_user_password_should_always_be_32_characters
    @user.password = "not 32 characters"
    assert !@user.save, "Saved user with a password shorter than 32 characters"
  end

  def test_user_emailaddress_should_be_unique
    @user.save!

    user = User.new
    user.username = "Another"
    user.emailaddress = "username@somewhere.com"
    user.password = "5f4dcc3b5aa765d61d8327deb882cf99"
    assert !user.save, "Saved user with a duplicate e-mail address"
  end

  def test_user_username_should_be_unique
    @user.save!

    user = User.new
    user.username = "Username"
    user.emailaddress = "username@somewhereelse.com"
    user.password = "5f4dcc3b5aa765d61d8327deb882cf99"
    assert !user.save, "Saved user with a duplicate username"
  end

  def test_user_username_is_between_3_and_20_characters
    @user.username = "ab"
    assert !@user.save, "Saved user with a username shorter than 3 characters"

    @user.username = "abcdefghijklmnopqrstuvwzyx"
    assert !@user.save, "Saved user with a username longer than 20 characters"

    @user.username = "ValidUsername"
    assert @user.save, "Did not save a user with a valid length username"
  end
  
end
