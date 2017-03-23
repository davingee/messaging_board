FactoryGirl.define do
  factory :user do

    sequence(:email)      { |n| "foo#{ n }@bar.com" }
    password              '1password1'
    password_confirmation '1password1'
    first_name            { Faker::Name.first_name } 
    last_name             { Faker::Name.last_name } 

  end

  factory :invalid_user, parent: :user do

    email                 nil
    password              nil
    password_confirmation nil
    first_name            nil
    last_name             nil

  end

end
