require File.dirname(__FILE__) + '/test_helper'

module AnyQueue
  class ArrayMessageTest < Test::Unit::TestCase
    
    test "that a file message will return the correct body" do
      original_msg = test_message
      
      message = ArrayMessage.new(original_msg)
      assert_equal original_msg, message.body
    end
  end
end