require File.dirname(__FILE__) + '/test_helper'
require 'starling'

module AnyQueue
  class StarlingProviderTest < Test::Unit::TestCase
    def setup
      @config = {
        :host => "127.0.0.1",
        :port => "22122",
        :queue => "test_queue"
      }
      
      @starling = Starling.new("#{@config[:host]}:#{@config[:port]}")
      @starling.flush(@config[:queue])
    end
    
    
    test "that pulling from the queue works correctly" do
      expected = rand(100000).to_s
      @starling.set(@config[:queue], expected)
      
      provider = AnyQueue::Provider.provider('starling', @config)
      provider.receive do |msg|
        assert_equal expected, msg
      end
    end
    
    test "that pushing into the queue works correctly" do
      expected = rand(100000).to_s
      
      provider = AnyQueue::Provider.provider('starling', @config)
      provider << expected
      
      assert_equal expected, @starling.fetch(@config[:queue])
    end
  end
end