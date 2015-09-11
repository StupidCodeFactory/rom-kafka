# encoding: utf-8
require "rom"
require "poseidon"
require "attributes_dsl"

# Ruby Object Mapper
#
# @see http://rom-rb.org/
#
module ROM

  # Apache Kafka support for ROM
  #
  # @see http://kafka.apache.org/
  #
  module Kafka

    require_relative "kafka/functions"
    require_relative "kafka/drivers"

    require_relative "kafka/dataset"
    require_relative "kafka/gateway"
    require_relative "kafka/relation"
    require_relative "kafka/create"

  end # module Kafka

end # module ROM
