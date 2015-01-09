require "test_helper"

class SessionTest < ActiveSupport::TestCase

  def session
    @session ||= Session.new
  end

  def test_valid
    assert session.valid?
  end

end
