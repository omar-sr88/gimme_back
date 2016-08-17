require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = User.first
    @other = User.second
    # This code is not idiomatically correct.
     # @item = @user.owned_items.build(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
     #    initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    @item = Item.create(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
        initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'omar123' } }

    @fake_params = {"name"=>"test",
                   "description"=>"test",
                   "date_lended"=>"11/08/2016",
                   "initial_return_date"=>"31/08/2016",
                   "is_guest"=>"0",
                   "recipient_id"=>"",
                   "guest_recipient"=>"John Wick",
                   "recipient_email"=>"duchess@example.gov"}
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_url(@item)
    assert_response :success
  end

  test "should update item" do
    patch item_url(@item), params: { item: { date_lended: @item.date_lended, description: @item.description, name: @item.name } }
    assert_redirected_to item_url(@item)
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end
    assert_redirected_to items_url
  end

end
