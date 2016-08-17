require 'test_helper'

class ItemCreationTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.first
    @other = User.second
    # This code is not idiomatically correct.
     # @item = @user.owned_items.build(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
     #    initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    @item = Item.new(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
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

  test "should item " do
    assert_difference('Item.count', +1) do
      @item.save
    end
  end


  test "should add item with user" do
    assert_difference('Item.count', +1) do
      @new_item = Item.prepare_for_save(@fake_params,@user)
      #did not add user
      assert_equal(2,User.count, "Got #{User.count}")
      assert_equal(1,@new_item.owner_id, "Got #{@new_item.owner_id} for owner ")
      assert_equal(2,@new_item.recipient_id, "Got #{@new_item.recipient_id} for recipient")
      assert @new_item.valid?
      @new_item.save
    end
    assert_equal("Sterling Archer", @new_item.recipient.name)
  end

  #  test "should add item with guest user creation" do
  #   @fake_params[:is_guest] = "1"
  #   assert_difference('Item.count', +1) do
  #     @new_item = Item.prepare_for_save(@fake_params,@user)
  #     assert_equal(3,User.count, "Got #{User.count}")
  #     assert_equal(1,@new_item.owner_id, "Got #{@new_item.owner_id} for owner ")
  #     #created an extra user
  #     assert_equal(User.last.id,@new_item.recipient_id, "Got #{@new_item.recipient_id} for recipient")
  #     assert @new_item.valid?
  #     @new_item.save
  #   end
  #   assert @new_item.recipient.name ==  @fake_params[:guest_recipient]
  # end

  # test "should NOT item with guest blank user" do
  #   @fake_params[:is_guest] = "1"
  #   @fake_params[:guest_recipient] = ""

  #   #assert_difference('Item.count', +0) do
	 #  @new_item = Item.prepare_for_save(@fake_params,@user)
	 #  assert_equal(2,User.count, "Got #{User.count}")
	 #  assert_equal(1,@new_item.owner_id, "Got #{@new_item.owner_id} for owner ")
	 #  #created an extra user
	 #  assert_equal(nil,@new_item.recipient_id, "Got #{@new_item.recipient_id} for recipient")
	 #  assert @new_item.errors.any?
	 #  @new_item.save
  #   #end
  # end


end