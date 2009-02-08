require 'test/test_helper'

module AnyQueue
  class FileMessageTest < Test::Unit::TestCase
    
    test "that a file message will return the correct body" do
      original_msg = test_message
      
      message = FileMessage.new(original_msg)
      assert_equal original_msg, message.body
    end
  end
end