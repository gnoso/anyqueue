require 'test/test_helper'

module AnyQueue
  class ProviderTest < Test::Unit::TestCase
    
    test "that registering a provider works" do
      # this is total abuse of the registration system, but it tests it
      # fairly accurately
      AnyQueue::Provider.register('test', String)
      
      assert_not_nil AnyQueue::Provider.provider('test', "")
    end
  end
end