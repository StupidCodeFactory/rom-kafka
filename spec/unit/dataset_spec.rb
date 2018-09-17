describe ROM::Kafka::Dataset do

  let(:gateway_class)  { ROM::Kafka::Gateway }
  let(:consumer_class) { ROM::Kafka::Connection::Consumer }
  let(:consumer)       { double :consumer }
  before { allow(consumer_class).to receive(:new) { consumer } }

  let(:kafka) { Kafka.new(['kafka:9092']) }
  let(:topic)   { "bar" }
  let(:options) { {} }
  subject { described_class.new(kafka, topic, options) }

  describe "#topic" do

    it "is initialized" do
      expect(subject.topic).to eq topic
    end
  end

  describe "#producer" do

    it "exists" do
      expect(kafka).to receive(:producer)
      subject.producer
    end
  end

  describe "#consumer" do
    it "is initialized with proper options" do
      expect(kafka).to receive(:consumer)
      subject.consumer
    end
  end

  describe "#using" do
    subject { dataset.using(update) }

    let(:dataset) { described_class.new gateway, topic, min_bytes: 8 }
    let(:update)  { { partition: 1, offset: 2 } }

    it "builds new dataset" do
      expect(subject).to be_kind_of described_class
    end

    it "preserves gateway" do
      expect(subject.gateway).to eql(gateway)
    end

    it "preserves topic" do
      expect(subject.topic).to eql(topic)
    end

    it "updates attributes" do
      expect(subject.attributes).to eql(dataset.attributes.merge(update))
    end
  end
end
