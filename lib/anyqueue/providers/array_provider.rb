module AnyQueue
  class ArrayMessage
    include AnyQueue::Message
    
    # Initializes a new message.
    #
    # ==== Parameters
    # base_message<String>:: The body of the message from the queue
    def initialize(base_message)
      @base_message = base_message
    end
    
    # Returns the raw body of the message. This is a bit sloppy for now
    # because we're actually converting the hash that we loaded back into
    # YAML.
    #
    # ==== Returns
    # String:: The body of the message.
    def body
      @base_message
    end
    
    # Does nothing in the array handler, because it always just deletes.
    def delete
    end
  end
  
  class ArrayProvider
    include AnyQueue::Provider
    
    AnyQueue::Provider.register("array", AnyQueue::ArrayProvider)
    
    # Initializes the provider. See AnyQueue::Provider#initialize for
    # more information.
    def initialize(config = nil)
      @queue_data = config || []
    end
    
    # Receives a message from the queue
    def receive
      if @queue_data.empty?
        nil
      else
        ArrayMessage.new(@queue_data.delete_at(0))
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