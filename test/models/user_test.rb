require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without name, email & password" do
    user = User.new
    assert_not user.save
  end

  test "should not save user without name" do
    user = User.new(email: 'z@z.xom', password: '123456')
    assert_not user.save
  end

  test "should not save user without password" do
    user = User.new(name: 'zz zz', email: 'z@z.xom')
    assert_not user.save
  end

  test "should not save user with password < 6 chars" do
    user = User.new(name: 'zz zz', email: 'z@z.com', password: '12345')
    assert_not user.save
  end

  test "should not save user with existing email" do
    user = User.new(name: 'zz zz', email: users(:user_1).email, password: '123456')
    assert_not user.save
  end

  test "should save a user with valid attributes" do
    user = User.new(name: 'zz zz', email: 'z@z.com', password: '123456')
    assert user.save
  end
end
