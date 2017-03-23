require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'methods' do 

    it 'should concat first and last name with space and capitalize each' do 
      user = FactoryGirl.build :user, first_name: 'foo', last_name: 'bar'
      user.name.should eq('Foo Bar')
    end

  end

end
