require 'test/test_helper'

module AnyQueue
  # Test implementation of a message
  class TestMessage
    include Message
  end
  
  class MessageTest < Test::Unit::TestCase
  
    test "that the default body method just raises an exception" do
      msg = TestMessage.new
      assert_raises RuntimeError do
        msg.body
      end
    end
    
    test "that the default delete just raises an exception" do
      msg = TestMessage.new
      assert_raises RuntimeError do
        msg.delete
      end
    end
    
    test "that the id method returns something" do
      msg = TestMessage.new
      assert_not_nil msg.id
    end
  end
end