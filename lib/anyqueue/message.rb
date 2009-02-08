require 'uuidtools'

module AnyQueue
  module Message
    # Returns the full body of the message from the queue.
    #
    # ==== Returns
    # Object:: The full body of the message from the queue.
    def body
      raise "Not Implemented!"
    end
    
    # Returns a unique id for the message, or just makes
    # one up if the queue does not support ids.
    #
    # ==== Returns
    # String:: id of queue message.
    def id
      @id ||= UUID.random_create.to_s
    
      return @id
    end
  
    # Deletes a message from its queue.
    def delete
      raise "Not Implemented!"
    end
  end
end