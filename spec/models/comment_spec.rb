require 'rails_helper'

RSpec.describe Comment, type: :model do
  let (:bad_comment) {FactoryBot.build(:comment, :invalid_comment)}
  let (:good_comment) {FactoryBot.build(:comment, :valid_comment)}

  describe 'basic validations for comment model' do
    it 'is valid when the length is right, it has an author and a post' do
      should allow_value(good_comment.content).for(:content)
      should allow_value(good_comment.commenter).for(:commenter)
      should allow_value(good_comment.post).for(:post)
    end

    it 'is not valid without content' do
      should_not allow_value(bad_comment.content).for(:content)
    end

    it 'is not valid if the comment exceeds length' do
      should_not allow_value('a' * 501).for(:content)
    end

    it 'is not valid without author' do
      should_not allow_value(bad_comment.commenter).for(:commenter)
    end

    it 'is not valid without a post' do
      should_not allow_value(bad_comment.post).for(:post)
    end
  end

  describe 'validating associations' do
    it 'belongs to user' do
      should belong_to(:commenter) 
    end

    it 'belongs to post' do
      should belong_to(:post)
    end
  end
end
