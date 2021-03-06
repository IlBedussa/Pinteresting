class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :validate_pins_count, only: [:new, :create]
  before_action :list_all_pins, only: [:new, :index]
 
  def index
  
end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      @user = current_user;
      # UserMailer.thanks_email(@user).deliver
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pin
    @pin = Pin.find(params[:id])
  end

  def correct_user
    @pin = current_user.pins.find_by(id: params[:id])
    redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pin_params
    params.require(:pin).permit(:description, :image)
  end
  
  #User can create only one pin
  def validate_pins_count
      if current_user.pins.count >= 1
        redirect_to pins_url, notice: 'You can create only one pin.'
      end
  end
  
  #to get all pins
  def list_all_pins
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  end
end
