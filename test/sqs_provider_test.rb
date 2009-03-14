require File.dirname(__FILE__) + '/test_helper'

module AnyQueue
  class SqsProviderTest < Test::Unit::TestCase
    
    test "that the sqs provider is properly registered" do
      assert_not_nil AnyQueue::Provider.provider("sqs", sqs_queue_config)
    end
    
    test "that we can configure and receive from an SQS queue" do
      sqs_post_test_message
      
      # test receiving a message from the queue
      provider = SqsProvider.new(sqs_queue_config)
      result = nil
      
      10.times do
        provider.receive do |msg|
          result = msg
        end
        break if result
      end
      
      # make sure we got something back
      assert_not_nil result
    end
    
    test "that messages are properly deleted from the queue" do
      sqs_post_test_message
      
      provider = SqsProvider.new(sqs_queue_config)
      found = nil
      10.times do
        provider.receive do |msg|
          found = msg
          true
        end
        break if found
      end
    end
    
    test "that we can push to a queue" do
      msg_body = UUID.random_create.to_s
      
      provider = SqsProvider.new(sqs_queue_config)
      provider.push(msg_body)
      
      matched = false
      10.times do
        msg = sqs_queue.receive
        if msg
          matched = matched || msg.body == msg_body
        end
      end
      
      assert matched
    end
    
    test "that we can push to a queue with <<" do
      msg_body = UUID.random_create.to_s
      
      provider = SqsProvider.new(sqs_queue_config)
      provider << msg_body
      
      matched = false
      10.times do
        msg = sqs_queue.receive
        if msg
          matched = matched || msg.body == msg_body
        end
      end
      
      assert matched
    end
  end
end