require 'spec_helper'
RSpec.describe PinsController do	
	before(:each) do
		@user = FactoryGirl.create(:user)
		logout(@user)
	end
	
	after(:each) do
		if !@user.destroyed?
			@user.destroy
		end
	end
	
	describe "GET index" do
		it "renders the index template" do
			get :index
			expect(response).to redirect_to(login_url)
		end
		
		it "populates @pins with all pins" do
			get :index
			expect(response).to redirect_to(login_url)
		end
		
		
	end
	
	describe "GET new" do
    it 'responds with successfully' do
      get :new
			expect(response).to redirect_to(login_url)
    end
    
    it 'renders the new view' do
      get :new      
			expect(response).to redirect_to(login_url)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
			expect(response).to redirect_to(login_url)
    end
  end
  
end