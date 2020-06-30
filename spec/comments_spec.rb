require 'rails_helper'

RSpec.describe 'Post', type: :model do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
    User.create(email: 'eric@gmail.com', name: 'Eric', password: 'eric1234', password_confirmation: 'eric1234')
    User.first.posts.create(content: 'post by user first')
  end

  it 'creates a comment for the first post' do
    user1 = User.first
    user2 = User.last
    user2.comments.create(content: 'comments for post 1 by user 2', post_id: user1.posts.first.id)
    expect(Post.first.comments.first.content).to eq('comments for post 1 by user 2')
  end

  it ' does not creates a comment for the first post without content' do
    user1 = User.first
    user2 = User.last
    comment = user2.comments.create(post_id: user1.posts.first.id)
    expect(comment.valid?).to be(false)
  end

  it 'counts the comments for the first post of user 2' do
    user1 = User.first
    user2 = User.last
    user2.comments.create(content: '1st comment for post 1 by user 2', post_id: user1.posts.first.id)
    user2.comments.create(content: '2nd comment for post 1 by user 2', post_id: user1.posts.first.id)
    user2.comments.create(content: '3rd comment for post 1 by user 2', post_id: user1.posts.first.id)
    expect(user2.comments.count).to eq(3)
  end
end
