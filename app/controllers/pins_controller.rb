class PinsController < ApplicationController
  before_action :require_login, except: [:index, :show, :show_by_name]
  
  def index
    @pins = Pin.all
  end
  
  def new
  	@pin = Pin.new
  	@pin.pinnings.build
  end
  
  def create
  	@pin = Pin.new(pin_params)
	if @pin.valid?
  		@pin.save
	  	redirect_to @pin
	else
		@errors = @pin.errors
		render :new
	end
  end
  
 def edit
 	@pin = Pin.find_by_id(params[:id])
 	render :edit
 end
  
def edit_by_name
	@pin = Pin.find_by_slug(params[:slug])
 	render :edit
end
  
   def update
 	@pin = Pin.find_by_id(params[:id])
 	@pin.update_attributes(pin_params)

 	if @pin.valid?
	 	
	 	redirect_to @pin
 	else
 		@errors = @pin.errors
 		render :edit
 	end
	end
  
  def show_by_name
  	@pin = Pin.find_by_slug(params[:slug])
  	@users = @pin.users
  	@user = current_user
  	render :show
  end
  
  def show
    @pin = Pin.find(params[:id])
    @users = @pin.users
  	@pins = current_user.pins
  	render :show
  end
  
  def repin
  	@pin = Pin.find(params[:id])
  	@pin.pinnings.create(user: current_user)
  	redirect_to user_path(current_user)
  end
  
private
  def pin_params
  	params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id, pinnings_attributes: [:board_id, :user_id, :id])
  end

################################### The Last End ###################################  
end