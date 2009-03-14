require File.dirname(__FILE__) + '/test_helper'

module AnyQueue
  class ArrayProviderTest < Test::Unit::TestCase
    def setup
      @queue_data = [
          'Message 1', 'Message 2', 'Message 3', 'Message 4'
        ]
    end
    
    test "that the provider is registered" do
      assert_not_nil AnyQueue::Provider.provider("array", 
        @queue_data)
    end
    
    test "that receiving a message works" do
      provider = ArrayProvider.new(@queue_data)
      
      messages = []
      4.times do
        provider.receive do |msg|
          messages << msg
          true
        end
      end
      
      assert_equal "Message 1", messages[0]
    end
    
    test "that messages are deleted from the queue correctly" do
      provider = ArrayProvider.new(@queue_data)
      
      4.times do
        provider.receive do |msg|
          true
        end
      end
      
      # this should be nil, since we cleared everything out
      provider.receive do |msg|
        assert_nil msg
      end
    end
    
    test "that pushing a message works" do
      provider = ArrayProvider.new(@queue_data)
      
      expected = test_message
      provider.push(expected)
      4.times do
        provider.receive
      end
      
      provider.receive do |msg|
        assert_equal expected, msg
      end
    end
    
    test "that pushing a message works with << syntax" do
      provider = ArrayProvider.new(@queue_data)
      
      expected = test_message
      provider << expected
      4.times do
        provider.receive
      end
      
      provider.receive do |msg|
        assert_equal expected, msg
      end
    end
    
    test "that initializing an array provider with no data works" do
      provider = ArrayProvider.new
      
      assert provider.to_a.empty?
    end
  end
end