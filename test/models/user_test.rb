require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

   def setup
    @user = User.new(name: "Primeiro usuario", email: "eu@servidor.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
end
