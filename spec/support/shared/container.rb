require 'rom/types'
RSpec.shared_examples 'container' do
  let(:configuration) { ROM::Configuration.new(:kafka, ['kafka:9092']) }
  let(:gateway)       { configuration.gateways[:default]  }

  let(:users_relation) { container.relations[:users] }
  let(:user_dataset)  do
    gateway.dataset(:users)
  end

  let(:container)     do
    ROM.container configuration
  end
end
