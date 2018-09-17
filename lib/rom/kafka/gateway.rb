module ROM::Kafka
  # Describes the gateway to Kafka
  #
  # The gateway has 3 responsibilities:
  # - registers the datasets describing various topics and partitions
  # - instantiates the producer connection to Kafka brokers that doesn't
  #   depend on a specific topic/partition settings
  # - stores settings for the consumer connections to Kafka, that
  #   depends on a specific topic/partition/offset
  #
  # Every dataset uses the same producer connection (defined by gateway) and
  # individual consumer's one. The consumer's connection is reloaded
  # every time the topic, partition or current offset is changed by a relation.
  #
  class Gateway < ROM::Gateway
    attr_accessor :connection, :datasets

    def initialize(addresses, **options) # @todo: refactor the fat initializer
      self.connection = Kafka.new(addresses, options)
      self.datasets = Concurrent::Map.new
    end

    # Returns the registered dataset by topic
    #
    # @param [#to_sym] topic
    #
    # @return [ROM::Kafka::Dataset]
    #
    def [](topic)
      datasets[topic.to_sym]
    end

    # Registers the dataset by topic
    #
    # By default the dataset is registered with 0 partition and 0 offset.
    # That settings can be changed from either relation of a command.
    #
    # @param [#to_sym] topic
    #
    # @return [self] itself
    #
    def dataset(topic)
      datasets[topic.to_sym] ||= Dataset.new(self, topic)
    end

    # Checks whether a dataset is registered by topic
    #
    # @param [#to_sym] topic
    #
    # @return [Boolean]
    #
    def dataset?(topic)
      !!self[topic]
    end

  end
end
