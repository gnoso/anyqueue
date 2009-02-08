require 'test/test_helper'

module AnyQueue
  class FileProviderTest < Test::Unit::TestCase
    def setup
      @queue_file = File.join(File.dirname(__FILE__), "fixtures",
          "queue.yml")
    end
    
    test "that the file provider is registered" do
      assert_not_nil AnyQueue::Provider.provider("file", 
          { :queue_file => @queue_file })
    end
    
    test "that receiving a message works" do
      provider = FileProvider.new({ :queue_file => @queue_file })
      
      messages = []
      4.times do
        messages << provider.receive
      end
      
      assert_nil provider.receive
      
      assert_equal "Message 1", messages[0].body
    end
    
    test "that pushing a message works" do
      provider = FileProvider.new({ :queue_file => @queue_file })
      
      msg = test_message
      provider.push(msg)
      4.times do
        provider.receive
      end
      
      assert_equal msg, provider.receive.body
    end
    
    test "that pushing a message works with << syntax" do
      provider = FileProvider.new({ :queue_file => @queue_file })
      
      msg = test_message
      provider << msg
      4.times do
        provider.receive
      end
      
      assert_equal msg, provider.receive.body
    end
  end
end