require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:valid_friendship) { FactoryBot.build(:friendship, :confirmed) }
  let(:rejected_friendship) { FactoryBot.build(:friendship, :rejected) }
  let(:pending_friendship) { FactoryBot.build(:friendship, :pending) }

  describe 'basic validations for friendship model' do
    context "validates presences" do
      it { should validate_presence_of(:user_id) }
      it { should validate_presence_of(:friend_id) }
    end
  end

  describe 'validating correct associations' do
    it 'belongs to User' do
      should belong_to(:user)
    end
  end

  # describe 'testing methods and scopes' do
  #   it 'should return confirmed friendships' do
  #
  #   end
  # end
end