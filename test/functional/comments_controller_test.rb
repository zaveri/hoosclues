require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	context "A Comment instance" do
		setup do
			@comment = Comment.find(:first)
		end
	
		should "return its content" do
			assert_equal 'cool picture', @comment.body
			assert_equal 'tester', @comment.commenter
		end
    # should "get index" do
    #   get :index, :id => pictures(:one).to_param, :id => comments(:one).to_param
    #     end
	end
end