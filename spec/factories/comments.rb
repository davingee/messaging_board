FactoryGirl.define do
  factory :comment do

    body    {Faker::Lorem.paragraph(3)}
    author  { User.first || association(:user) }
    post    { Post.first || association(:post) }

  end

  factory :invalid_comment, parent: :comment do

    body    nil
    author  nil
    post    nil

  end

end
