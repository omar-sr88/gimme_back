require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:omar)
  end

  test "unsuccessful edit" do
  	get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'omar123' } }
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  #stuck because of standrd www.example.com host
  test "successful edit with friendly forwarding" do
    delete logout_path
    assert_not is_logged_in?
    get edit_user_path(@user)
    assert_redirected_to login_path
    post login_path, params: { session: { email: @user.email,
                                          password: "omar123",
                                          remember_me: 1 } }
    #assert_redirected_to user_path(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

end
