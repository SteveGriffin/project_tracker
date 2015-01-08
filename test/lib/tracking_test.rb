require 'test_helper'
require 'tracking'

class TestsTracker < ActionController::TestCase
  setup do
    #@test = tests(:one)
  end

  test "should get time" do
    @a = Tracking.get_time
    assert_kind_of Time, @a
  end

end
