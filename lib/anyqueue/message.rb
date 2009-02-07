require 'uuidtools'

module AnyQueue::Message
  # Returns the full body of the message from the queue.
  #
  # ==== Returns
  # Object:: The full body of the message from the queue.
  def body
    raise "Not Implemented!"
  end
  
  # Returns a parsed YAML representation of the body of the
  # message from the queue.
  #
  # ==== Returns
  # Object:: The object resulting from loading the message
  # body as YAML
  def data
    @data ||= YAML::load(body)
    return @data
  end
  
  # Returns the type of the message. This is the type property
  # in the YAML data in the queue, or nil if no type property
  # exists.
  #
  # ==== Returns
  # String:: The type of the message, or nil
  def type
    data['type'] || data[:type] if data && data.is_a?(Hash)
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