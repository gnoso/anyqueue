require 'test/test_helper'

module AnyQueue
  class FileMessageTest < Test::Unit::TestCase
    
    test "that a file message will return the correct body" do
      original_msg = { :type => "NoType", :message => "This is a test" }
      original_body = YAML::dump(original_msg)
      
      message = FileMessage.new(original_msg)
      assert_equal original_body, message.body
    end
    
    test "that data for a message returns correctly" do
      original_msg = { :type => "NoType", :message => "This is a test" }
      
      msg = FileMessage.new(original_msg)
      assert_equal original_msg, msg.data
    end
  end
end