# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post, :valid_post) }
  let(:no_post) { FactoryBot.build(:post, :invalid_post) }

  describe 'basic validations for post model' do

    it 'is not valid without content' do
      should_not allow_value(no_post.content).for(:content)
    end

    it 'is not valid if it has more than 500 char' do
      should_not allow_value('a' * 501).for(:content)
    end

    it 'is not valid if it has proper length data but no author' do
      should allow_value(post.content).for(:content)
      should_not allow_value(no_post.author).for(:author)
    end

    it 'is valid if it has proper length data AND author' do
      should allow_value(post.content).for(:content)
      should allow_value(post.author).for(:author)
    end
  end

  describe 'validating correct associations' do

    it 'belongs to User' do
      should belong_to(:author)
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end
  end
end
