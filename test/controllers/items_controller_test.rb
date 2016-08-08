require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  # test "should show item" do
  #   get item_url(@item)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_item_url(@item)
  #   assert_response :success
  # end

  # test "should update item" do
  #   patch item_url(@item), params: { item: { date_lended: @item.date_lended, description: @item.description, name: @item.name } }
  #   assert_redirected_to item_url(@item)
  # end

  # test "should destroy item" do
  #   assert_difference('Item.count', -1) do
  #     delete item_url(@item)
  #   end

  #   assert_redirected_to items_url
  # end
end
