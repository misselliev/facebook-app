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

  # describe 'validating correct associations' do
  #    it 'has correct associations with posts' do
  #     should have_many(:posts)
  #    end

  #   it 'has correct associations with comments' do
  #     should have_many(:comments)
  #   end

  #   it 'has correct associations with likes' do
  #     should have_many(:likes)
  #   end
  # end

end