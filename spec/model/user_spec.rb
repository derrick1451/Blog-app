require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(Name: 'derrick', Photo: 'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'teacher') }
  before { subject.save }

  it 'name should be present' do
    subject.Name = nil
    expect(subject).not_to be_valid
  end

  it 'return correct data type' do
    subject.PostsCounter = 'melon'
    expect(subject).not_to be_valid
  end
  it 'use correct data type' do
    subject.PostsCounter = 1
    expect(subject).to be_valid
  end
  it 'is not valid if posts_Counter is negative' do
    subject.PostsCounter = -2
    expect(subject).not_to be_valid
  end
end
