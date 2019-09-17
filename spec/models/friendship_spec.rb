# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:valid_friendship) { FactoryBot.build(:friendship, :confirmed) }
  let(:rejected_friendship) { FactoryBot.build(:friendship, :rejected) }
  let(:pending_friendship) { FactoryBot.build(:friendship, :pending) }
  let(:incomplete_friendship) { FactoryBot.build(:friendship, :incomplete) }

  describe 'basic validations for friendship model' do
    context 'validates presences' do
      it { should validate_presence_of(:user_id) }
      it { should validate_presence_of(:friend_id) }
    end

    it 'is not valid without a user_id' do
      should_not allow_value(incomplete_friendship.user_id).for(:user_id)
    end

    it 'is not valid without a friend_id' do
      should_not allow_value(incomplete_friendship.friend_id).for(:friend_id)
    end

    it 'is has a valid user_id' do
      should allow_value(valid_friendship.user_id).for(:user_id)
    end

    it 'is has a valid friend_id' do
      should allow_value(valid_friendship.friend_id).for(:friend_id)
    end
  end

  describe 'validating correct associations' do
    it 'belongs to User' do
      should belong_to(:user)
    end

    it 'belongs to Friend' do
      should belong_to(:friend)
    end
  end

  describe 'testing methods and scopes' do
    it 'should return confirmed friendship when confirmed is true' do
      should allow_value(valid_friendship.confirmed).for(:confirmed)
    end

    it 'should return pending friendship when confirmed is nil' do
      should allow_value(pending_friendship.confirmed).for(:confirmed)
    end

    it 'should return rejected friendship when confirmed is false' do
      should allow_value(rejected_friendship.confirmed).for(:confirmed)
    end
  end
end