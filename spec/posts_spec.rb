require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    User.create(email: 'john@gmail.com', name: 'John', password: 'john1234', password_confirmation: 'john1234')
    User.create(email: 'eric@gmail.com', name: 'Eric', password: 'eric1234', password_confirmation: 'eric1234')
  end

  it 'creates a post' do
    User.first.posts.create(content: 'post by user first')
    User.first.posts.create(content: 'second post by user first')
    expect(User.first.posts.count).to eq(2)
  end

  it 'checks the content of a post' do
    User.first.posts.create(content: 'post by user first')
    expect(User.first.posts.first.content).to eq('post by user first')
  end

  it 'checks the content of a comment' do
    User.first.posts.create(content: 'post by user first')
    Post.first.comments.create(content: 'first comment of this post', user_id: User.last.id)
    expect(User.first.posts.first.comments.first.content).to eq('first comment of this post')
  end

  it 'counts the number of comment on a post' do
    User.first.posts.create(content: 'post by user first')
    Post.first.comments.create(content: 'first comment of this post', user_id: User.last.id)
    Post.first.comments.create(content: 'second comment of this post', user_id: User.last.id)
    expect(User.first.posts.first.comments.count).to eq(2)
  end

  it 'Finds text content Recent posts after logging in' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'john@gmail.com'
    fill_in 'user_password', with: 'john1234'
    click_button 'Log in'
    sleep(3)
    visit '/posts'
    sleep(1)
    expect(page).to have_content('Recent posts')
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
