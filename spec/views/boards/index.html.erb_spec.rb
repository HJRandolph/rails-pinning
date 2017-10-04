require 'spec_helper'

RSpec.describe "boards/index", type: :view do
  before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)

    assign(:boards, [
      Board.create!(
        :name => "Name",
        :user => @user
      ),
      Board.create!(
        :name => "Name",
        :user => @user
      )
    ])
  end
  after(:each) do
    if !@user.destroyed?
      @user.pinnings.destroy_all
      @user.boards.destroy_all 
      @user.destroy
    end
    end

  it "renders a list of boards" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
   # assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
