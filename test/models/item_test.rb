require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @user = User.first
    @other = User.second
    # This code is not idiomatically correct.
     # @item = @user.owned_items.build(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
     #    initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    @item = Item.create(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
        initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "save empty item" do
    assert_not Item.new.save()
  end

  test "name  should be present" do
    @item.name = nil
    assert_not @item.valid?
  end

  test "user id should be present" do
    @item.owner_id = nil
    assert_not @item.valid?
  end

  test "recipient id should be present" do
    @item.recipient_id = nil
    assert_not @item.valid?
  end

  test "name size min" do
    skip
  end  

  test "name size max" do
    skip
  end  

  test "are users related?" do
    skip
  end
	
  test "item has image" do
    skip

  end

  test "date landed in the past?" do
    skip

  end

  test "initial return date post lend date" do
    skip
  end


end
