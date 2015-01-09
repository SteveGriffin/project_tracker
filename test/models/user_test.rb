require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= User.new(email: "test2@test.com", password: "test")
  end


  def test_valid
    assert user.valid?, "User valid"
  end

end
