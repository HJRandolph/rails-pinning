require 'spec_helper'

RSpec.describe "boards/show", type: :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
