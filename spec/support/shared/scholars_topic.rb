shared_examples :scholars_topic do
  let(:commad_klass) do
    Class.new(ROM::Commands::Create) do
      adapter :kafka

      def execute(tuples)
        tuples.each do |tuple|
          relation << tuple
        end
      end
    end
  end
  let(:scolar_klass) do
    Class.new(ROM::Relation[:kafka]) do

      schema :scholars do
        attribute :value, ROM::Types::String
      end
    end
  end

  let!(:rom) do
    options = { client_id: "admin" }
    ROM.container(:kafka, "localhost:9092", options) do |config|
      config.register_relation(scolar_klass)
    end
  end

  let(:scholars) { rom.relations[:scholars] }
  let(:insert)   do
    scholars.command(:create)
  end
end
