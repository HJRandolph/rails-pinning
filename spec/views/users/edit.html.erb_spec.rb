require 'spec_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
     @user = FactoryGirl.create(:user)
  end
  
  after(:each) do
  	@user.destroy
  end
  
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@user.first_name)
    expect(rendered).to match(@user.last_name)
    expect(rendered).to match(@user.email)
  end
  #it "renders the edit user form" do
  # render

#	 assert_select "form[action=?][method=?]", user_path(@user), "post" do

#      assert_select "input#user_first_name[name=?]", "user[first_name]"

#      assert_select "input#user_last_name[name=?]", "user[last_name]"

#      assert_select "input#user_email[name=?]", "user[email]"

#      assert_select "input#user_password[name=?]", "user[password]"
#    end
#  end
end
