class PinsController < ApplicationController
  before_action :require_login, except: [:show, :show_by_name]
  
  def index
    @pins = current_user.pins
  end
  
  def new
  	@pin = Pin.new
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
  	render :show
  end
  
  def show
    @pin = Pin.find(params[:id])
  end
  
private
  def pin_params
  	params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image, :user_id)
  end

################################### The Last End ###################################  
end