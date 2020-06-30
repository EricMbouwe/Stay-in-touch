require 'rails_helper'

RSpec.describe 'User', type: :model do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
    User.create(email: 'eric@gmail.com', name: 'Eric', password: 'eric1234', password_confirmation: 'eric1234')
  end

  it 'creates a friendship request' do
    user1 = User.first
    user2 = User.last
    Friendship.create(user_id: user1.id, friend_id: user2.id, status: 0)
    expect(User.find(user1.friendships.first.friend_id).name).to eq('Eric')
  end

  it 'tries to add a user without email and fails' do
    user3 = User.create(name: 'kilyan', password: 'abc123')
    expect(user3.valid?).to be(false)
  end

  it 'checks inverse friendship' do
    user1 = User.first
    user2 = User.last
    Friendship.create(user_id: user1.id, friend_id: user2.id, status: 0)
    expect(User.find(user2.friendship_requests.first.user_id).name).to eq('John')
  end

  it 'creates post by user' do
    user1 = User.first
    user1.posts.create(content: 'post created by John')
    user1.posts.create(content: 'second post created by John')
    expect(user1.posts.count).to eq(2)
  end

  it 'confirms comment on post by user' do
    user1 = User.first
    user2 = User.last
    post1 = user1.posts.create(content: 'post created by John')
    user1.posts.create(content: 'second post created by John')
    user2.comments.create(content: 'some comments', post_id: post1.id)

    expect(user2.comments.first.post.content).to eq('post created by John')
  end
end
