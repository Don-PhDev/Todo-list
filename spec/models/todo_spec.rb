require 'rails_helper'

RSpec.describe Todo, type: :model do
  context 'validations' do
    subject { FactoryBot.create(:todo) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end
end
