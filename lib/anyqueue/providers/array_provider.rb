module AnyQueue  
  class ArrayProvider
    include AnyQueue::Provider
    
    AnyQueue::Provider.register("array", AnyQueue::ArrayProvider)
    
    # Initializes the provider. See AnyQueue::Provider#initialize for
    # more information.
    def initialize(config = nil)
      @queue_data = config || []
    end
    
    # Receives a message from the queue
    # Expects a block that will receive the message as a parameter. The
    # block should return true if the message should be removed from the
    # queue or false if it should not.
    def receive
      if @queue_data.empty?
        nil
      else
        msg = @queue_data.delete_at(0)
        if block_given?
          result = yield msg
        end
        @queue_data << msg if !result
      end
    end
   
    # Pushes a message to the queue.
    def push(msg)
      @queue_data << msg
    end
    
    # Returns an array representing the data in this queue.
    def to_a
      @queue_data
    end
  end
end