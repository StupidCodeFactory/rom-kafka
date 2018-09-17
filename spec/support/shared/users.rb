RSpec.shared_examples 'users and tasks' do
  before do
    user_dataset.insert name: 'John Doe', age: 36
    user_dataset.insert name: 'Jane Doe', age: 37
  end

end
