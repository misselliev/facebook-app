# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new }
  describe 'basic validations for post model' do
    it 'is not valid without content' do
      expect(subject).not_to be_valid
    end

    it 'is not valid if it has more than 500 char' do
      subject.content = 'a' * 501
      expect(subject).not_to be_valid
    end

    it 'is not valid if it has proper length data but no author' do
      subject.content = 'a' * 499
      expect(subject).not_to be_valid
    end
  end

  describe 'validating correct associations' do
    it "has many comments" do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
    end

    it "has many likes" do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
    end
  end

end
