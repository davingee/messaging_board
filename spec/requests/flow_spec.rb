require 'rails_helper'

RSpec.describe "users flow", js: true do

  scenario "load homepage, sign up, create post, create comment" do

    visit root_path

    ## create user
    click_link('Sign Up')
    fill_in('Email', :with => 'foo@bar.com')
    fill_in('First name', :with => 'foo')
    fill_in('Last name', :with => 'bar')
    fill_in('Password', :with => '1foobar1')
    fill_in('Password confirmation', :with => '1foobar1')
    click_on('Create User')
    current_path.should == '/'

    ## create post
    click_link('New Message')
    fill_in('Post Title', :with => 'test title')
    fill_in('Body', :with => Faker::Lorem.paragraph(3))
    click_on('Create Post')

    page.should have_content('test title')
    current_path.should  match(/\/posts\/\d{1,}/)

    ## create comment
    fill_in('Comment', :with => 'neat test post')
    click_on('Create Comment')
    current_path.should  match(/\/posts\/\d{1,}/)

    page.should have_content('neat test post')

  end

end
