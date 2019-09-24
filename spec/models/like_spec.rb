# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:good_like) { FactoryBot.build(:like, :valid_like) }
  let(:bad_like) { FactoryBot.build(:like, :invalid_like) }

  describe 'basic validations for like' do
    it 'is not valid without user' do
      should_not allow_value(bad_like.user).for(:user)
    end

    it 'is not valid without post' do
      should_not allow_value(bad_like.post).for(:post)
    end

    it 'is valid when it has a user and a post' do
      should allow_value(good_like.user).for(:user)
      should allow_value(good_like.post).for(:post)
    end
  end
  describe 'validating basic associations' do
    it 'should belong to user' do
      should belong_to(:user)
    end

    it 'should belong to post' do
      should belong_to(:post)
    end
  end
end
