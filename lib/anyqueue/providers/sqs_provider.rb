require 'right_aws'

module AnyQueue
  class SqsMessage
    include AnyQueue::Message
    
    # Initializes a new message.
    #
    # ==== Parameters
    # message<Right::Sqs::Message>:: A message from the queue
    def initialize(base_message)
      @base_message = base_message
    end
    
    # Returns the raw body of the SQS message.
    #
    # ==== Returns
    # String:: The body of the SQS message.
    def body
      @base_message.body
    end
    
    # Deletes this message from the queue.
    def delete
      @base_message.delete
    end
  end
  
  class SqsProvider
    include Provider
    
    AnyQueue::Provider.register('sqs', AnyQueue::SqsProvider)
    
    # Initializes the provider. See AnyQueue::Provider#initialize for
    # more information.
    #
    # ==== Raises
    # RuntimeError:: If any configuration isn't correct for connecting
    # to SQS
    def initialize(config)
      sqs = RightAws::SqsGen2.new(config['aws_access_key_id'],
          config['aws_secret_access_key'])
      @queue = sqs.queue(config['queue'])
    end
    
    # Receives a message from the queue
    def receive
      base_msg = @queue.receive
      
      return nil if !base_msg
      
      SqsMessage.new(base_msg)
    end
    
    # Pushes a message to the queue
    #
    # ==== Parameters
    # message<String>:: The message to push to the queue
    def push(message)
      @queue.send_message(message)
    end
  end
end