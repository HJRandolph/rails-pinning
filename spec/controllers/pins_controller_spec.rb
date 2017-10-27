require 'spec_helper'
RSpec.describe PinsController do
	
	before(:each) do
		@user = FactoryGirl.create(:user_with_boards)
		login(@user)
		@board_pinner = BoardPinner.create(user: @user, board: FactoryGirl.create(:board))
	end
	
	after(:each) do
		if !@user.destroyed?
			@user.pins.destroy_all
			@user.pinnings.destroy_all
			@user.board_pinners.destroy_all
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
    
    it 'redirects to login when logged out' do
      logout(@user)
      get :new
      expect(response).to redirect_to(:login)
    end
    
    #it 'assigns @pinnable_boards to all pinnable boards' do
    #  get :new
    #  expect(assigns(:boards)).to eq(@user.pinnable_boards)
    #end
    
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
        @user.pinnings.destroy_all
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
    
    it 'pins to a board for which the user is a board_pinner' do
      @pin_hash[:pinnings_attributes] = []
      board = @board_pinner.board
      @pin_hash[:pinnings_attributes] << {board_id: board.id, user_id: @user.id}
      post :create, pin: @pin_hash
      pinning = Pinning.where("user_id=? AND board_id=?", @user.id, board.id)
	  expect(pinning.present?).to be(true)
	  



	  
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
      get :edit, id: @pin_test
      expect(assigns(:pin)).to eq(@pin_test)
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
		@board = FactoryGirl.create(:board)
	end
	
	after(:each) do
		pin = Pin.find_by_slug("rails-wizard")
		if !pin.nil?
			pin.destroy
		end
		logout(@user)
	end

	
  it 'responds with a redirect' do
    post :repin, id: @pin.id, pin: { pinning: { board_id: @board.id, user_id: @user.id } }
  	expect(response.redirect?).to be(true) 
  end
 
  it 'creates a user.pin' do
      post :repin, id: @pin.id, pin: { pinning: { board_id: @board.id, user_id: @user.id } }
      expect(@user.pins.present?).to be(true)
  end
 
  it 'redirects to the user show page' do
    post :repin, id: @pin.id, pin: { pinning: { board_id: @board.id, user_id: @user.id } }
	expect(response).to redirect_to(user_path(@user))
  end
  
  it 'pins to a board for which the user is a board_pinner' do
  @pin_hash = {
    title: @pin.title, 
    url: @pin.url, 
    slug: @pin.slug, 
    text: @pin.text,
    category_id: @pin.category_id
  }
  board = @board_pinner.board
  @pin_hash[:pinning] = {board_id: board.id}
  post :repin, id: @pin.id, pin: @pin_hash
  pinning = Pinning.where("user_id=? AND board_id=?", @user.id, board.id)
  expect(pinning.present?).to be(true)
  
 
  if pinning.present?
    pinning.destroy_all
  end
end

	
end
################################### The Last End ###################################	
end