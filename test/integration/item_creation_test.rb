require 'test_helper'

class ItemCreationTest < ActionDispatch::IntegrationTest
  
  def setup
    # @user = User.first
    # @other = User.second
    # # This code is not idiomatically correct.
    #  # @item = @user.owned_items.build(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
    #  #    initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    # @item = Item.new(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
    #     initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    # get login_path
    # post login_path, params: { session: { email:    @user.email,
    #                                       password: 'omar123' } }
    @item = FactoryGirl.build(:item)
    @guest = FactoryGirl.build(:guest)
    @fake_params = {"name"=>"test",
                   "description"=>"test",
                   "date_lended"=>"11/08/2016",
                   "initial_return_date"=>"31/08/2016",
                   "is_guest"=>"0",
                   "recipient_id"=>"",
                   "guest_recipient"=>"John Wick",
                   "recipient_email"=>"duchess@example.gov",
                   "guest_phone" => "123456798",
                   "guest_email" => "email@test.com"
                 }
  end

  test "should item " do
    assert_difference('Item.count', +1) do
      @item.save
    end
  end

  test "should add item with user" do
    assert_difference('Item.count', +1) do
      @item.save
    end
    assert_match(/User Name/, @item.recipient.name)
  end

  test "should add item with guest" do
    assert_difference('Item.count', +1) do
      @item = FactoryGirl.create(:item,recipient: @guest)
    end
    assert_match(/Guest Name/, @item.recipient.name) 
  end


  test "should test prepare for save with guest" do
    @fake_params[:is_guest] = "1"
    user = FactoryGirl.create(:user)
    user_count = User.count
    assert  @fake_params["is_guest"] , "1"
    assert_difference('User.count', +1) do
      assert @guest.valid? , @guest.errors.messages
      assert @guest.save
      # assert guest.save
    end
  end

 
end