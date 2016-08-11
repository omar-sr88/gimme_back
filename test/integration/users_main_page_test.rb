require 'test_helper'

class UsersMainPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @current_user = users(:omar)
  end

  test "main page" do
    get login_path
    post login_path, params: { session: { email:    @current_user.email,
                                          password: 'omar123' } }
    assert is_logged_in?
    get items_path
    assert_template 'items/index'

     assert_select "title" ,{ :count => 1, :html => /Items List/ }
    # assert_select 'subtitle', text: @user.name
    # assert_select 'h1>img.gravatar'
    # assert_match @user.microposts.count.to_s, response.body
    # assert_select 'div.pagination'
    # @user.microposts.paginate(page: 1).each do |micropost|
    #   assert_match micropost.content, response.body
    # end
  end
end