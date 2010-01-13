require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :picture
end
