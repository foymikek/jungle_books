require 'rails_helper'

RSpec.describe , type: :model do
  describe 'validations' do
    it { should validate_presence_of :author}
    it { should validate_presence_of :title}
  end

  describe 'relationships' do
    it {should belong_to :}
    it {should have_many :}
  end

  describe 'instance methods' do
  end
end