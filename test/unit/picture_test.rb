require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  should_belong_to :user
  should_have_many :comments
end
