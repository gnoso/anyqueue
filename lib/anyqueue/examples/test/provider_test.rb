require File.dirname(__FILE__) + '/test_helper'

module AnyQueue
  # Test implementation of the base provider
  class TestProvider
    include Provider
  end
  
  class TestProviderWithNew
    include Provider
    
    # Empty initializer that doesn't raise anything
    def initialize(config)
      
    end
  end
  
  class ProviderTest < Test::Unit::TestCase
    
    test "that registering a provider works" do
      # this is total abuse of the registration system, but it tests it
      # fairly accurately
      AnyQueue::Provider.register('test', String)
      
      assert_not_nil AnyQueue::Provider.provider('test', "")
    end
    
    test "that initializing raises an exception because it's not implemented" do
      assert_raises RuntimeError do
        provider = TestProvider.new({})
      end
    end
    
    test "that receiving a message raises an exception because it's not implemented" do
      provider = TestProviderWithNew.new({})
      assert_raises RuntimeError do
        provider.receive
      end
    end
    
    test "that pushing raises an exception because it's not implemented" do
      provider = TestProviderWithNew.new({})
      assert_raises RuntimeError do
        provider.push("Test Message")
      end
    end
  end
end