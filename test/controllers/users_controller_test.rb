require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest


  def setup
    @user       = users(:omar)
    @other_user = users(:other)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end


  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

end
