# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:author, :valid_user) }
  let(:invalid_user) { FactoryBot.build(:author, :invalid_user) }

  describe 'basic validations for user model' do
    context 'validates presences' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:lastname) }
      it { should validate_presence_of(:password) }
      it { should validate_presence_of(:email) }
    end

    it 'has a valid name' do
      should allow_value(user.name).for(:name)
    end

    it 'has an invalid name' do
      should_not allow_value(invalid_user.name).for(:name)
    end

    it 'has a valid lastname' do
      should allow_value(user.lastname).for(:lastname)
    end

    it 'has an invalid lastname' do
      should_not allow_value(invalid_user.lastname).for(:lastname)
    end

    it 'has a valid email' do
      should allow_value(user.email).for(:email)
    end

    it 'has an invalid email' do
      should_not allow_value(invalid_user.email).for(:email)
    end

    it 'has a valid password' do
      should allow_value(user.password).for(:password)
    end

    it 'has an invalid password, min length' do
      should_not allow_value(invalid_user.password).for(:password)
    end

    it 'has an invalid password, max length' do
      should_not allow_value('0123456789abcdefg').for(:password)
    end
  end

  describe 'validating correct associations' do
    it 'has many posts' do
      assc = described_class.reflect_on_association(:posts)
      expect(assc.macro).to eq :has_many
    end

    it 'has many comments' do
      assc = described_class.reflect_on_association(:comments)
      expect(assc.macro).to eq :has_many
    end

    it 'has many likes' do
      assc = described_class.reflect_on_association(:likes)
      expect(assc.macro).to eq :has_many
    end

    it 'has many friendships' do
      assc = described_class.reflect_on_association(:friendships)
      expect(assc.macro).to eq :has_many
    end
    it 'has many inverse_friendships' do
      assc = described_class.reflect_on_association(:inverse_friendships)
      expect(assc.macro).to eq :has_many
    end
  end
end
