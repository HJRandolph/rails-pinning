require 'spec_helper'
require 'database_cleaner'

RSpec.describe BoardsController, type: :controller do
	before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)
		@board = @user.boards.first
	end
	
	after(:each) do
		if !@user.destroyed?
			@user.pins.destroy_all
			@user.boards.destroy_all
			@user.destroy
		end
	end

describe "GET new" do
	it 'renders with successfully' do
		get :new
      	expect(response.success?).to be(true)
	end
	
	it 'renders the new view' do
		get :new
		expect(response).to render_template("new")
	end
	
	it 'assigns an instance variable to a new board' do
		get :new
		expect(assigns(:board)).to be_a_new(Board)
	end
	
	it 'redirects to the login page if user is not logged in' do
		logout(@user)
		get :new
		expect(response.redirect?).to be(true)
	end

end

describe "POST create" do
	before(:each) do
		@board_hash = {
			name: "My pins!"
		}
	end
	
	after(:each) do
		board = Board.find_by_name("My pins!")
		if !board.nil?
			board.destroy
		end
	end
	
	it 'responds with a redirect' do
		post :create, board: @board_hash
		expect(response.redirect?).to be(true)
	end
	
	it 'creates a board' do
		post :create, board: @board_hash
		expect(Board.find_by_name("My pins!").present?).to be(true)
	end
	
	it 'redirects to the show view' do
		post :create, board: @board_hash
		expect(response).to redirect_to(board_url(assigns(:board)))
	end
	
	it 'redisplays new form on error' do
		@board_hash[:name] = nil
		post :create, board: @board_hash
		expect(response).to render_template(:new)
	end
	
	it 'redirects to the login page if user is not logged in' do
		logout(@user)
		post :create, board: @board_hash
		expect(response).to redirect_to(:login)
	end
end

describe "GET #show" do

	it "assigns the requested board" do
		get :show, {:id => @board.to_param}
		expect(assigns(:board)).to eq(@board)
	end
	
	it "assigns the @pins variable with the board's pins" do
		get :show, id: @board.id
		expect(assigns(:pins)).to eq(@board.pins)
	end

end
########################### The Last End ###########################
end
