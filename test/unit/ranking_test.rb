require 'test_helper'

class RankingTest < ActiveSupport::TestCase
  should_belong_to :picture
  should_belong_to :user
end
