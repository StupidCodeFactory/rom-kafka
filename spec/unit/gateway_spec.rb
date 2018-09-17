describe ROM::Kafka::Gateway do

  subject { described_class.new(['kafka:9092']) }

  describe ".new" do
    context "with brokers URLs" do

      it { is_expected.to be_kind_of ROM::Gateway }
    end

    context "without brokers URLs" do

      it "fails" do
        expect { described_class.new }.to raise_error ArgumentError
      end
    end
  end

  describe "#[]" do

    it { expect(subject[:foo]).to eql(nil) }
  end

  describe "#dataset?" do
    before do
      allow(subject).to receive(:[]) { |name| { foo: :FOO }[name.to_sym] }
    end

    context "when dataset is registered" do

      it { is_expected.to be_a_dataset :foo }
    end

    context "when dataset isn't registered" do

      it { is_expected.to_not be_a_dataset :bar }
    end
  end

  describe "#dataset" do
    subject { gateway.dataset topic }

    let(:klass)   { ROM::Kafka::Dataset }
    let(:dataset) { double :dataset }
    let(:topic)   { "foobar" }

    before { allow(klass).to receive(:new) { dataset } }

    it "builds a dataset" do
      expect(klass).to receive(:new).with(gateway, topic)
      subject
    end

    it "registers a dataset by symbol" do
      expect { subject }.to change { gateway[:foobar] }.from(nil).to(dataset)
    end

    it "registers a dataset by string" do
      expect { subject }.to change { gateway["foobar"] }.from(nil).to(dataset)
    end

    it "returns a dataset" do
      expect(subject).to eql(dataset)
    end
  end

  describe "#producer" do
    subject { gateway.producer }
    let(:producer) { double :producer }

    it "builds a producer" do
      attributes = {}
      producer   = double :producer

      expect(ROM::Kafka::Connection::Producer).to receive(:new) do |opts|
        attributes = opts
        producer
      end
      expect(subject).to eql producer
      expect(attributes).to eql gateway.attributes
    end
  end
end
