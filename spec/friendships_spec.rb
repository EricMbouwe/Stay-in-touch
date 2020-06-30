require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
    User.create(email: 'eric@gmail.com', name: 'Eric', password: 'eric1234', password_confirmation: 'eric1234')
  end

  it 'creates a friendship by user 1 and accept it by user 2' do
    user1 = User.first
    user2 = User.last
    fr = user1.invite(user2)
    fr.confirm
    expect(user1.friends.first.name).to eq('Eric')
    expect(user2.friends.first.name).to eq('John')
  end

  it 'checks pending friends' do
    user1 = User.first
    user2 = User.last
    user1.invite(user2)
    expect(user1.pending_friendships.first.friend.name).to eq('Eric')
  end

  it 'checks inverse_friendship' do
    user1 = User.first
    user2 = User.last
    user1.invite(user2)
    expect(user2.friendship_requests.count).to eq(1)
  end

  it 'rejects a friendship request' do
    user1 = User.first
    user2 = User.last
    fr = user1.invite(user2)
    fr.reject
    expect(fr.status).to eq(-1)
  end

  it 'accepts a friendship request' do
    user1 = User.first
    user2 = User.last
    fr = user1.invite(user2)
    fr.confirm
    expect(fr.status).to eq(1)
  end
end
