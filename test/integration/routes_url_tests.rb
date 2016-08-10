require 'test_helper'

class RoutesUrlsTests < ActionDispatch::IntegrationTest

	def setup
      @user = users(:omar)
      #@request.host = 'http://localhost/'
 	end


	test "root url" do
	  	get root_url
	    assert(request.original_url.include? "localhost")
  	end

	test "root url2" do
	  get root_url
  	  assert(request.original_url == "http://localhost/", request.original_url)
	end

	test "url for user" do
	  s = open_session
	  s.host!("localhost")
	  get login_path
	  post login_path, params: { session: { email:    @user.email,
	                                          password: 'omar123' } }
	  assert is_logged_in?
	  get edit_user_path(@user)
      assert_template 'users/edit'	
      assert(request.original_url == "http://localhost/user/1", request.original_url)

	end

end