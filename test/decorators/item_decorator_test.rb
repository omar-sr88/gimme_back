requite 'test/unit'
class ItemDecoratorTest < ActiveSupport::TestCase

 def setup
    @user = User.first
    @other = User.second
    # This code is not idiomatically correct.
     # @item = @user.owned_items.build(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
     #    initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
    @item = Item.create(name: "Lorem ipsum", date_lended: '11/01/2014 13:23',
        initial_return_date: '12/01/2014', owner_id: @user.id , recipient_id: @other.id)
  end

 test "progress days left" do

 end

 test "progress status msg" do

 end
 
 test "progress class" do

 end

end