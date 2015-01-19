require "test_helper"

class CollaboratorTest < ActiveSupport::TestCase

  def collaborator
    @collaborator ||= Collaborator.new
  end

  def test_valid
    assert collaborator.valid?
  end

end
