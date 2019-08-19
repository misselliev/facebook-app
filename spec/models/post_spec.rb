# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { Post.new }

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
