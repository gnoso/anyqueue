require 'test/test_helper'

module AnyQueue
  class ArrayProviderTest < Test::Unit::TestCase
    def setup
      @queue_data = [
          'Message 1', 'Message 2', 'Message 3', 'Message 4'
        ]
    end
    
    test "that the file provider is registered" do
      assert_not_nil AnyQueue::Provider.provider("array", 
        @queue_data)
    end
    
    test "that receiving a message works" do
      provider = ArrayProvider.new(@queue_data)
      
      messages = []
      4.times do
        messages << provider.receive
      end
      
      assert_nil provider.receive
      
      assert_equal "Message 1", messages[0].body
    end
    
    test "that pushing a message works" do
      provider = ArrayProvider.new(@queue_data)
      
      msg = test_message
      provider.push(msg)
      4.times do
        provider.receive
      end
      
      assert_equal msg, provider.receive.body
    end
    
    test "that pushing a message works with << syntax" do
      provider = ArrayProvider.new(@queue_data)
      
      msg = test_message
      provider << msg
      4.times do
        provider.receive
      end
      
      assert_equal msg, provider.receive.body
    end
    
    test "that initializing an array provider with no data works" do
      provider = ArrayProvider.new
      
      assert provider.to_a.empty?
    end
  end
end