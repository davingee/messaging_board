FactoryGirl.define do
  factory :post do

    title     {Faker::Name.title}
    body      {Faker::Lorem.paragraph(3)}
    author    { User.first || association(:user) }
    # author    { association(:user) }

  end

  factory :invalid_post, parent: :post do

    title   nil
    body    nil
    author  nil

  end

end
