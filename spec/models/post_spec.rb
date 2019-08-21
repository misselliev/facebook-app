# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let (:author) do
    User.new(id: 1,
             name: 'Dulce',
             lastname: 'Woof',
             email: 'dulce@woof.com',
             password: '123456',
             password_confirmation: '123456')
  end

  subject { Post.new }

  describe 'basic validations for post model' do
    it 'is not valid without content' do
      should_not allow_value('').for(:content)
    end

    it 'is not valid if it has more than 500 char' do
      should_not allow_value('a' * 501).for(:content)
    end

    it 'is not valid if it has proper length data but no author' do
      should allow_value('a' * 500).for(:content)
      should_not allow_value(nil).for(:author)
    end

    it 'is valid if it has proper length data AND author' do
      should allow_value('a' * 500).for(:content)
      should allow_value(author).for(:author)
    end
  end

  describe 'validating correct associations' do
    subject { Post.new(author: author) }

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
