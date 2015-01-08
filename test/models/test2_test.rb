require "test_helper"

class Test2Test < ActiveSupport::TestCase

  def test2
    @test2 ||= Test2.new
  end

  def test_valid
    assert test2.valid?
  end

end
