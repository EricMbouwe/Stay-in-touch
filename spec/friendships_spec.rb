require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
    User.create(email: 'eric@gmail.com', name: 'Eric', password: 'eric1234', password_confirmation: 'eric1234')
  end

  it 'creates a friendship by user 1 and accept it by user 2' do
    user1 = User.first
    user2 = User.last
    Friendship.create(user_id: user1.id, friend_id: user2.id, status: 0)
    fr = user1.friendships.first
    fr.status = 1
    fr.save
    expect(user1.friends.first.name).to eq('Eric')
  end

  it 'checks pending friendship' do
    user1 = User.first
    user2 = User.last
    Friendship.create(user_id: user1.id, friend_id: user2.id, status: 0)
    expect(user1.pending_friends.first.name).to eq('Eric')
  end

  it 'checks inverse_friendship' do
    user1 = User.first
    user2 = User.last
    Friendship.create(user_id: user1.id, friend_id: user2.id, status: 0)
    expect(user2.inverse_friendships.count).to eq(1)
  end
end
