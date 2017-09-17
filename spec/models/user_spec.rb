require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  

before(:all) do
  @user = User.create(first_name: "Jane", last_name: "Doe", email: "coder@skillcrush", password: "password")
end
 
after(:all) do
  if !@user.destroyed?
    @user.destroy
  end
end
 
it 'authenticates and returns a user when valid email and password passed in' do
	authenticate_user = User.authenticate(@user.email, @user.password)
	expect(authenticate_user).to eql(@user)
end
  
it { should validate_presence_of(:first_name) }
it { should validate_presence_of(:last_name) }
it { should validate_presence_of(:email) }
it { should validate_presence_of(:password) }

it { should validate_uniqueness_of(:email) }

end
