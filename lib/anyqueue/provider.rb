module AnyQueue
  module Provider
    
    # Initializes the provider based on the configuration in the
    # cavort.yml file.
    #
    # ==== Parameters
    # config<Hash>:: A hash of configuration options
    def initialize(config)
      raise "Not implemented!"
    end
  
    # Receives a message from the queue.
    #
    # Expects a block that will receive the message as a parameter. The
    # block should return true if the message should be removed from the
    # queue or false if it should not.
    def receive
      raise "Not Implemented!"
    end
  
    # Pushes a message onto the queue that this provider is connected to.
    #
    # ==== Parameters
    # message<String>:: The content to be pushed as a message to the queue.
    def push(message)
      raise "Not Implemented!"
    end

    # Alias for push
    #
    # ==== Parameters
    # message<String>:: The content to be pushed as a message to the queue.
    def <<(message)
      push message
    end
  
    # Registers a class with a particular type of provider in AnyQueue.
    #
    # ==== Parameters
    # type<String>:: The provider name.
    # 
    def self.register(type, register_class)
      @@registered_providers ||= {}
      @@registered_providers[type] = register_class
    end
  
    # Returns a new instance of a provider with the type given.
    def self.provider(type, config = nil)
      @@registered_providers[type].new(config)
    end
  end
end