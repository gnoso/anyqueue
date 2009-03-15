module AnyQueue  
  class StarlingProvider
    include AnyQueue::Provider
    
    AnyQueue::Provider.register("starling", AnyQueue::StarlingProvider)
    
    # Initializes the provider. See AnyQueue::Provider#initialize for
    # more information.
    #
    # Configuration Parameters
    #   host: The hostname to connecto to
    #   port: The port to connect to
    #   queue: The queue to connect to
    def initialize(config = nil)
      require 'starling'
      
      @starling = Starling.new("#{config[:host]}:#{config[:port]}")
      @queue = config[:queue]
    end
    
    # Receives a message from the queue
    # Expects a block that will receive the message as a parameter. The
    # block should return true if the message should be removed from the
    # queue or false if it should not.
    def receive
      msg = @starling.fetch(@queue)
      if block_given?
        result = yield msg
      end
      @starling.set(@queue, msg) if !result
    end
   
    # Pushes a message to the queue.
    def push(msg)
      @starling.set(@queue, msg)
    end
  end
end