namespace :db do

  desc "Seed with fake data"
  task :seeder => :environment do
    (1..2).to_a.each do |u|
      user = FactoryGirl.create :user
      (1..12).to_a.each do |p|
        post = FactoryGirl.create :post, author: user
        (1..12).to_a.each do |c|
          FactoryGirl.create :comment, author: user, post_id: post.id
        end
      end
    end
  end

  desc "Delete All"
  task :delete_all => :environment do
    [User, Post, Comment].each do |k|
      k.destroy_all
    end
  end

end
