require "ruby-kafka"
require "rom"
require "rom-sql"
require 'byebug'
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
    require_relative "kafka/dataset"
    require_relative "kafka/gateway"
    require_relative "kafka/commands/create"
    require_relative "kafka/relation"
  end


end

ROM.register_adapter(:kafka, ROM::Kafka)
