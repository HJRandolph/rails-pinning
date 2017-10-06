require 'spec_helper'

RSpec.describe "boards/show", type: :view do
  before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)

    @board =  Board.create!(
        :name => "Name",
        :user => @user
      )
 
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
    expect(@board.name).to eq("Name")
    expect(rendered).to match(//)
  end
end
