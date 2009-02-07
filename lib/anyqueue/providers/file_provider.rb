module AnyQueue
  class FileMessage
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
      YAML::dump(@base_message)
    end
    
    # Returns the data for this message.
    # 
    # ==== Returns
    # Hash:: The data as parsed as YAML from the message.
    def data
      return @base_message
    end
    
    # Does nothing in the file message handler, because the file provider
    # just works sequentially through the file.
    def delete
    end
  end
  
  class FileProvider
    include AnyQueue::Provider
    
    AnyQueue::Provider.register("file", AnyQueue::FileProvider)
    
    # Initializes the provider. See AnyQueue::Provider#initialize for
    # more information.
    #
    # ==== Raises
    # RuntimeError:: If the file given isn't correct.
    def initialize(config)
      @queue_data = YAML::load_file(
          config[:queue_file] || config['queue_file'])
      @queue_index = 0
    end
    
    # Receives a message from the queue
    def receive
      if @queue_index < @queue_data.length
        msg = FileMessage.new(@queue_data[@queue_index])
        @queue_index += 1
        return msg
      else
        return nil
      end
    end
  end
end