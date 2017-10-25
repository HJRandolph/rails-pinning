require 'spec_helper'

RSpec.describe "followers/show", type: :view do
    before(:each) do
    @user = FactoryGirl.create(:user_with_followees)
    @board = @user.boards.first
    login(@user)
  end
  
  after(:each) do
    if !@user.destroyed?
      Follower.where("follower_id=?", @user.id).first.destroy
    end
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
