require 'spec_helper'

RSpec.describe ROM::Kafka::Commands::Create do

  include_context 'container'

  before do
    configuration.relation(:users)
    configuration.commands(:users) do
      define :create
    end
  end

  include_context 'users and tasks'
  subject do
    described_class.new(users_relation)
  end
  it 'does something' do
    expect { subject }.to_not raise_error
  end


  # let(:gateway) { ROM::Kafka::Gateway.new(['kafka:9092']) }

  # let(:relation) do
  #   ROM::Kafka::Relation.new gateway.dataset(:users)
  # end
  # subject do
  #   byebug
  #   described_class.new relation
  # end
  # # let(:relation) { double :relation, dataset: dataset }
  # let(:dataset)  { double :dataset, producer: producer, topic: "qux" }
  # let(:producer) { double :producer, publish: output }
  # let(:output)   { double :output }

  # describe ".adapter" do

  #   it { expect(described_class.adapter).to eq(:kafka) }
  # end

  # describe ".new" do
  #   it { is_expected.to be_kind_of ROM::Commands::Create }
  # end

  # describe "#key" do
  #   subject { command.key }

  #   it { is_expected.to be_nil }
  # end

  # describe "#with" do
  #   subject { command.with(key: "foo") }

  #   it "returns a command" do
  #     expect(subject).to be_kind_of described_class
  #   end

  #   it "preserves current relation" do
  #     expect(subject.relation).to eql relation
  #   end

  #   it "updates the key" do
  #     expect(subject.key).to eql("foo")
  #   end
  # end

  # describe "#call" do
  #   subject { command.call(:bar, ["baz"]) }

  #   context "when key isn't set" do
  #     let(:bar) { { value: "bar", topic: "qux", key: nil } }
  #     let(:baz) { { value: "baz", topic: "qux", key: nil } }

  #     it "publishes tuples to the producer" do
  #       expect(producer).to receive(:publish).with(bar, baz)
  #       subject
  #     end

  #     it "returns tuples" do
  #       expect(subject).to eql output
  #     end
  #   end

  #   context "when key is set" do
  #     let(:command) { described_class.new(relation).with(key: "foo") }

  #     let(:bar) { { value: "bar", topic: "qux", key: "foo" } }
  #     let(:baz) { { value: "baz", topic: "qux", key: "foo" } }

  #     it "publishes tuples to the producer" do
  #       expect(producer).to receive(:publish).with(bar, baz)
  #       subject
  #     end

  #     it "returns tuples" do
  #       expect(subject).to eql output
  #     end
  #   end
  # end
end
