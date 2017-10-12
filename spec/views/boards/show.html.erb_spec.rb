require 'spec_helper'

RSpec.describe "boards/show", type: :view do
  before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)

   
    	board = Board.create!(
    	  :name => "Name",
    	  :user => @user
    	)
    	assign(:board, board)
    	
    
    	pins = FactoryGirl.create(:pin) 

    	assign(:pins, [
    		FactoryGirl.create(:pin),
    		FactoryGirl.create(:pin),
    		FactoryGirl.create(:pin) 
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
  end
 
  
end

 
