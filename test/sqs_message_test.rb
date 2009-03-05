require File.dirname(__FILE__) + '/test_helper'

module AnyQueue
  class SqsMessageTest < Test::Unit::TestCase
    def setup
      sqs_queue.clear
      @right_msg = sqs_post_test_message

      @provider = SqsProvider.new(sqs_queue_config)
    end
    
    test "that id is returned correctly" do
      msg = certain_receive
      
      assert_equal @right_msg.id, msg.id
      msg.delete
    end
    
    test "that body is returned correctly" do
      msg = certain_receive
      
      assert_equal @right_msg.body, msg.body
      msg.delete
    end
    
    test "that deleting a message works correctly" do
      msg = certain_receive
      msg.delete
      
      assert 0, sqs_queue.size
    end
    
    private
      # Loops several times to make sure we get a message off of the
      # SQS queue
      def certain_receive
        msg = nil
        10.times do
          msg = @provider.receive
          break if msg
        end
        
        return msg
      end
  end
end