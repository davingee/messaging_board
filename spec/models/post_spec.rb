require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'scope :newest_first' do 

    it 'should list the newest post first.' do
      post_old = FactoryGirl.create :post, created_at: 1.days.ago
      post_new = FactoryGirl.create :post
      posts = Post.newest_first
      posts.first.id.should eq( post_new.id )
      posts.last.id.should eq( post_old.id )
    end

  end

  context 'post comments order should be newest first.' do 

    it 'should list the newest post first' do
      post = FactoryGirl.create :post
      comment_old = FactoryGirl.create :comment, post: post, created_at: 1.days.ago
      comment_new = FactoryGirl.create :comment, post: post
      comments = post.comments
      comments.first.id.should eq( comment_new.id )
      comments.last.id.should eq( comment_old.id )
    end

  end

end
