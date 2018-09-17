module ROM::Kafka
  # The dataset describes Kafka topic
  #
  # @api private
  #
  class Dataset

    include Enumerable

    attr_accessor :kafka, :topic, :consumer_options, :producer_options

    def initialize(gateway, topic, consumer_options: {}, producer_options: {})
      self.kafka   = gateway.connection
      self.topic   = topic
      self.consumer_options = consumer_options
      self.producer_options = producer_options
    end

    def insert(tuples, options: {})
      producer.produce(tuples.to_json, topic: topic, **options)
    end

    def producer
      @producer ||= kafka.producer
    end

    def consumer
      @consumer ||= kafka.consumer.tap do |c|
        p.subscribe(topic, **producer_options)
      end
    end

    # Returns the enumerator to iterate via tuples, fetched from a [#consumer].
    #
    # If a `limit` of messages is set, iterator stops after achieving it.
    #
    # @param [Proc] block
    #
    # @yieldparam [Hash] tuple
    #
    # @return [Enumerator<Hash{Symbol => String, Integer}>]
    #
    def each(&block)
      return to_enum unless block_given?
      limit.equal?(0) ? unlimited_each(&block) : limited_each(&block)
    end

    private

    def prepare_consumer
      Connection::Consumer.new consumer_options
    end

    def consumer_options
      attributes.merge(
        topic: topic,
        client_id: gateway.client_id,
        brokers: gateway.brokers
      )
    end

    def unlimited_each
      enum = consumer.each
      loop { yield(enum.next) }
    end

    def limited_each
      enum = consumer.each
      limit.times { yield(enum.next) }
    end
  end
end
