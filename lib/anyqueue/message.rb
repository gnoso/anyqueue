module AnyQueue
  module Message
    # Returns the full body of the message from the queue.
    #
    # ==== Returns
    # Object:: The full body of the message from the queue.
    def body
      raise "Not Implemented!"
    end
  
    # Deletes a message from its queue.
    def delete
      raise "Not Implemented!"
    end
  end
end