require 'spec_helper'
RSpec.describe PinsController do
	
	before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)
	end
	
	after(:each) do
		if !@user.destroyed?
			@user.pinnings.destroy_all
			@user.pins.destroy_all
			@user.boards.destroy_all
			@user.destroy
		end
	end
	
	describe "GET index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
		end
		
		it "populates @pins with all pins" do
			get :index
			expect(response).to render_template("index")
		end
		
		
	end
	
	describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
 
 
  
################################### Create Tests ###################################
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
  end
  
################################### Edit/Update Tests ################################### 
describe "GET edit" do
   before(:each) do
      @pin_test = Pin.first   
    end



    it 'responds with successfully' do
      get :edit, pin: @pin_test
      expect(response.success?).to be(true)
    end
    
    it 'renders the edit view' do
      get :edit, id: @pin_test
      expect(response).to render_template(:edit)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :edit, id: @pin_test.id
      expect(assigns(:pin)).to eq(Pin.find(1))
    end
  end
    

################# UPDATE tests #################
describe "POST update" do
    before(:each) do
    	@pin = Pin.first
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: 2}    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
      	pin.pinnings.destroy_all
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :update, pin: @pin_hash, id: @pin
      expect(response).to redirect_to(pin_path)
      #expect(response.redirect?).to be(true)
    end

    
    it 'updates a pin' do
      post :update, pin: @pin_hash, id: @pin
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :update, pin: @pin_hash, id: @pin.id
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays edit form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :edit, pin: @pin_hash
      expect(response).to render_template(:edit)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash[:title] = "  "
      post :update, pin: @pin_hash, id: @pin.id
      expect(assigns[:errors].present?).to be(true)
  	 end    
    
  end

################################### REPINNING ###################################  
describe "POST repin" do
	before(:each) do 
		@user = FactoryGirl.create(:user)
		login(@user)
		@pin = FactoryGirl.create(:pin)

	end
	
	after(:each) do
		pinning = Pinning.find_by(user_id: @user.id)
		if !pinning.nil?
			pinning.destroy
		end
		pin = Pin.find_by_slug("rails-cheatsheet")
		if !@pin.nil?

			@pin.destroy
		end
		logout(@user)
	end

	
  it 'responds with a redirect' do
  	post :repin, id: @pin.id, pin: [user_id: @user.id]
  	expect(response.redirect?).to be(true) 
  end
 
  it 'creates a user.pin' do
      post :repin, {:id => @pin.to_param}
      expect(@user.pins.present?).to be(true)
  end
 
  it 'redirects to the user show page' do
	post :repin, { :id => @pin.to_param }
	expect(response).to redirect_to(user_path(@user))
  end
	
end
################################### The Last End ###################################	
end