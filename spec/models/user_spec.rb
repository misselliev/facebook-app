require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'basic validations for user model' do
    it 'has a valid name' do
      expect(user).to be_valid 
    end

    it 'has an invalid name' do
      user.name = "aa"
      expect(user).not_to be_valid 
    end
    
      it 'has a valid lastname' do
      expect(user).to be_valid 
    end

    it 'has an invalid lastname' do
      user.lastname = "aa"
      expect(user).not_to be_valid 
    end

    it 'has a valid email' do
      expect(user).to be_valid 
    end

    it 'has an invalid email' do
      user.email = "aa@netco"
      expect(user).not_to be_valid 
    end

    it 'has a valid password' do
      expect(user).to be_valid 
    end

    it 'has an invalid password, min length' do
      user.password = "aa"
      expect(user).not_to be_valid 
    end

    it 'has an invalid password, max length' do
      user.password = "a" * 16
      expect(user).not_to be_valid 
    end
  end

  describe 'validating correct associations' do
    it "has many posts" do
    assc = described_class.reflect_on_association(:posts)
    expect(assc.macro).to eq :has_many
    end

    it "has many comments" do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
    end

    it "has many likes" do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
    end

    it "has many friendships" do
    assc = described_class.reflect_on_association(:friendships)
    expect(assc.macro).to eq :has_many
    end
  end

end