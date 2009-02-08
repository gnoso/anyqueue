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
  
    # Reserves a message in the queue and returns a AnyQueue::Message,
    # or nil if no messages are available in the queue.
    # 
    # ==== Returns
    # AnyQueue::Message:: The next message from the queue, or nil if no
    #   messages are in the queue.
    def reserve
      raise "Not Implemented!"
    end
  
    # Pushes a message onto the queue that this provider is connected to.
    #
    # ==== Parameters
    # message<String>:: The content to be pushed as a message to the queue.
    def push(message)
      raise "Not Implemented!"
    end
    alias :<< :push
  
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
    def self.provider(type, config)
      @@registered_providers[type].new(config)
    end
  end
end