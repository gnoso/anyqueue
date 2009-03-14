require 'right_aws'

module AnyQueue
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
      if block_given?
        body = base_msg ? base_msg.body : nil
        result = yield body
      end
      base_msg.delete if base_msg && result
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