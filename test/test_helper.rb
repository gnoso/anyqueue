require 'test/unit'
require 'lib/cavort'

class Test::Unit::TestCase
  # test "verify something" do
  #   ...
  # end
  def self.test(name, &block)
    test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    if block_given?
      define_method(test_name, &block)
    else
      define_method(test_name) do
        flunk "No implementation provided for #{name}"
      end
    end
  end
  
  # Returns a hash that's a reasonable config for an SQS queue
  def sqs_queue_config
    {
      'provider' => "Sqs",
      'queue' => "cavort_test",
      'aws_access_key_id' => ENV['AWS_ACCESS_KEY_ID'],
      'aws_secret_access_key' => ENV['AWS_SECRET_ACCESS_KEY']
    }
  end

  # Returns a RightAws::Sqs::Queue object
  def sqs_queue
    @@sqs ||= RightAws::SqsGen2.new(sqs_queue_config['aws_access_key_id'],
          sqs_queue_config['aws_secret_access_key'])
    @@sqs_queue ||= @@sqs.queue(sqs_queue_config['queue'])
  end
  
  # Returns a test message as a hash.
  def test_message
    {
      :type => "Test",
      :foo => "bar",
      :monkey => "awesome"
    }
  end
  
  # Posts a test message to an sqs queue
  def sqs_post_test_message
    sqs_queue.send_message(YAML::dump(test_message))
  end
end